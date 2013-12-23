#!/bin/bash

#####################
## Install packages

function install_packages()
{
    sudo apt-get -y install git-core cmake libmysqlclient-dev libxml2-dev libmcrypt-dev libicu-dev openssl build-essential binutils-dev libcap-dev zlib1g-dev libtbb-dev libonig-dev libpcre3-dev autoconf libtool libcurl4-openssl-dev wget memcached libreadline-dev libncurses-dev libmemcached-dev libbz2-dev libc-client2007e-dev php5-mcrypt php5-imagick libgoogle-perftools-dev libcloog-ppl0 libelf-dev libdwarf-dev libunwind7-dev subversion libtbb2 libtbb-dev g++-4.7 gcc-4.7 libjemalloc-dev libc6-dev libmpfr4 libgcc1 binutils libc6 libc-dev-bin libc-bin libgomp1 libstdc++6-4.7-dev libstdc++6 cmake libarchive12 cmake-data libacl1 libattr1 g++ cpp gcc make libboost-thread1.49.0 libboost-thread-dev libgd2-xpm-dev pkg-config libdwarf-dev binutils-dev libboost-system1.49-dev libboost-program-options1.49-dev libboost-filesystem1.49-dev libboost-regex1.49-dev
    return 0
}

#####################
## Get HHVM

function get_hhvm()
{
    cd ~
    mkdir dev
    cd dev
    git clone https://github.com/danslo/hhvm
    export CMAKE_PREFIX_PATH=`pwd`
    cd hhvm
    git submodule init
    cd ..
    return 0
}

#####################
## Build libevent

function build_libevent()
{
    git clone git://github.com/libevent/libevent.git
    cd libevent
    git checkout release-1.4.14b-stable
    cat ../hhvm/hphp/third_party/libevent-1.4.14.fb-changes.diff | patch -p1
    ./autogen.sh
    ./configure --prefix=$CMAKE_PREFIX_PATH
    make
    make install
    cd ..
    return 0
}

#####################
## Build Google glog

function build_google_glog()
{
    svn checkout http://google-glog.googlecode.com/svn/trunk/ google-glog
    cd google-glog
    ./configure --prefix=$CMAKE_PREFIX_PATH
    make
    make install
    cd ..
    return 0
}

#####################
## Build HHVM

function build_hhvm()
{
    cd hhvm
    git submodule update
    export HPHP_HOME=`pwd`
    cmake .
    make
    cd ..
    return 0
}

#####################
## Install n98-magerun

function install_n98_magerun()
{
    cd n98-magerun
    wget https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar
    chmod +x ./n98-magerun.phar
    sudo cp ./n98-magerun.phar /usr/local/bin
    cd ..
    return 0
}

#####################
## Install Magento

function install_magento()
{
    cd /var/www/
    sudo chmod 777 /var/www/magento-hhvm/
    n98-magerun.phar install --dbHost="localhost" --dbUser="magentouser" --dbPass="magentopwd" --dbName="magento" --installSampleData=yes --useDefaultConfigParams=yes --magentoVersionByName="magento-ce-1.8.0.0" --installationFolder="magento-hhvm" --baseUrl="http://magento-hhvm.local/"
    cd -
    return 0
}

#####################
## Stop Apache

function stop_apache()
{
    sudo /etc/init.d/apache2 stop
    return 0
}

#####################
## Start hhvm

function start_hhvm()
{
    sudo /home/vagrant/dev/hhvm/hphp/hhvm/hhvm -m server -c /var/vagrant/files/magento-config.hdf -vServer.IniFile=/var/vagrant/files/hhvm.ini -v Eval.CheckSymLink=true
    return 0
}

#####################
## Main script

install_packages
get_hhvm
build_libevent
build_google_glog
build_hhvm
install_n98_magerun
install_magento
# stop_apache
# start_hhvm
