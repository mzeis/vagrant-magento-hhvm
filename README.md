Vagrant for Magento on HHVM
=====================
This is a Vagrant configuration for getting a basic version of Magento with HHVM up and running. It is based on a template by [PuPHPet](https://puphpet.com/).

Version
-------
1.1.0

What do you get?
-------------------------
A VirtualBox image

* for VirtualBox 4.2
* based on Debian Wheezy 7.1

including

* Apache
* PHP 5.5 (Opcache enabled with default configuration)
* MySQL
* HHVM (Daniel Sloof's patched version)
* n98-magerun
* modman
* Magento CE 1.8 installed by n98-magerun

Usage
---------

1. Clone this repository
2. Change to the directory and execute `vagrant up`
3. SSH into your VM (execute `vagrant ssh` or if this doesn't work connect to 127.0.0.1:2222 as printed on screen)
4. Execute `/var/vagrant/shell/install-hhvm.sh`. This will take a while as > 350 MB are downloaded and HHVM is compiled which can take anywhere from 30 minutes to several hours.
5. Add a host entry to your hosts file:

         192.168.56.101 magento-hhvm.local
6. If everything worked then you will get a running Apache instance and can open `http://magento-hhvm.local/` in your browser.
7. To use HHVM instead of Apache shut down Apache and launch HHVM:

         sudo /etc/init.d/apache2 stop
         sudo /home/vagrant/dev/hhvm/hphp/hhvm/hhvm -m server -c /var/vagrant/files/magento-config.hdf -vServer.IniFile=/var/vagrant/files/hhvm.ini
7. If you reload `http://magento-hhvm.local/` HHVM should be at duty and boosting your store as soon as the JIT compiler kicks in.

Default credentials
-------------------

By default, these credentials are used:

### SSH

IP: 127.0.0.1

Port: 2222

User: vagrant

Password: vagrant

### MySQL

Database name: magento

User: magentouser

Password: magentopwd

### Magento Admin User

User: admin

Password: password123

What if I...
------------

### want to change credentials?
* Edit `puppet/hieradata/common.yaml` and `shell/install-hhvm.sh` for changing MySQL credentials.
* Modify the `n98-magerun.phar` to change Magento credentials as specified in the [n98-magerun Wiki](https://github.com/netz98/n98-magerun/wiki/Magento-installer).

### want to use NFS for the shared folder?
* Edit `Vagrantfile`.

### want to change the IP?
* Edit `Vagrantfile`.

Contribution
------------
Any contribution is highly appreciated. The best way to contribute code is to open a [pull request on GitHub](https://help.github.com/articles/using-pull-requests).

Changelog
---------

### v1.1.0
* HHVM based on master branch by Daniel Sloof (#1)
* Switched to PHP 5.5 with Opcache enabled (default configuration (#2)
* Adjusted manifest for Puppet 3.4 (see [puphpet/issues#347](https://github.com/puphpet/puphpet/issues/347))
* Install modman
* Allow symlinks for templates

### v1.0.0
* Initial release

Developer
---------
Matthias Zeis

* [http://www.matthias-zeis.com](http://www.matthias-zeis.com)  
* [@mzeis](https://twitter.com/mzeis)

License
-------
MIT License (see LICENSE file)

Copyright
---------
(c) 2013 Matthias Zeis
