Vagrant.configure("2") do |config|
  config.vm.box = "debian-wheezy71-x64-vbox42"
  config.vm.box_url = "http://box.puphpet.com/debian-wheezy71-x64-vbox42.box"

  config.vm.network "private_network", ip: "192.168.56.101"


  config.vm.synced_folder "./", "/var/vagrant", id: "vagrant-root", :nfs => false

  config.vm.usable_port_range = (2200..2250)
  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--name", "magento-hhvm"]
    virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # virtualbox.customize ["modifyvm", :id, "--memory", "1024"]
    virtualbox.customize ["modifyvm", :id, "--memory", "2048"]
    virtualbox.customize ["modifyvm", :id, "--cpus", "2"]
    virtualbox.customize ["modifyvm", :id, "--ioapic", "on"]
    virtualbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.provision :shell, :path => "shell/initial-setup.sh"
  config.vm.provision :shell, :path => "shell/update-puppet.sh"
  config.vm.provision :shell, :path => "shell/librarian-puppet-vagrant.sh"
  config.vm.provision :puppet do |puppet|
    puppet.facter = {
      "ssh_username" => "vagrant"
    }

    puppet.manifests_path = "puppet/manifests"
    puppet.options = ["--verbose", "--hiera_config /vagrant/hiera.yaml", "--parser future"]
  end




  config.ssh.username = "vagrant"

  config.ssh.shell = "bash -l"

  config.ssh.keep_alive = true
  config.ssh.forward_agent = false
  config.ssh.forward_x11 = false
  config.vagrant.host = :detect
end

