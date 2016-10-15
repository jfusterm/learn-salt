# -*- mode: ruby -*-
# vi: set ft=ruby :

CONFIG = File.join(File.dirname(__FILE__), "config.rb")

if File.exist?(CONFIG)
  require CONFIG
end

Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |vb|
    vb.gui = $vm_gui
    vb.memory = $vm_memory
    vb.cpus = $vm_cpus
    vb.check_guest_additions = false
  end

  config.vm.define :"salt-master" do |master_config|
    master_config.vm.box = "ubuntu/xenial64"
    master_config.vm.host_name = 'salt-master'
    master_config.vm.network "private_network", ip: "192.168.43.10"

    master_config.vm.provision :salt do |salt|
      salt.master_config = "conf/master"
      salt.install_type = $install_type
      salt.install_master = true
      salt.install_syndic = $install_syndic 
      salt.no_minion = true
      salt.verbose = $verbose
      salt.colorize = $colorize
      salt.bootstrap_options = ""
    end
  end
  
  config.vm.define :"salt-minion1" do |minion1_config|
    minion1_config.vm.box = "ubuntu/xenial64"
    minion1_config.vm.host_name = 'salt-minion1'
    minion1_config.vm.network "private_network", ip: "192.168.43.11"

    config.vm.provision :salt do |salt|
      salt.minion_config = "conf/minion"
      salt.install_type = $install_type
      salt.verbose = $verbose
      salt.colorize = $colorize
      salt.bootstrap_options = "-X"
    end
    config.vm.provision "shell", path: "scripts/set_id.sh"
  end


  config.vm.define :"salt-minion2", autostart: false do |minion2_config|
    minion2_config.vm.box = "centos/7"
    minion2_config.vm.host_name = 'salt-minion2'
    minion2_config.vm.network "private_network", ip: "192.168.43.12"

    config.vm.provision :salt do |salt|
      salt.minion_config = "conf/minion"
      salt.install_type = $install_type
      salt.verbose = $verbose
      salt.colorize = $colorize
      salt.bootstrap_options = "-X"
    end
    config.vm.provision "shell", path: "scripts/set_id.sh"
  end

  
  config.vm.define :"salt-minion3", autostart: false do |minion3_config|
    minion3_config.vm.box = "debian/jessie64"
    minion3_config.vm.host_name = 'salt-minion3'
    minion3_config.vm.network "private_network", ip: "192.168.43.13"

    config.vm.provision :salt do |salt|
      salt.minion_config = "conf/minion"
      salt.install_type = $install_type
      salt.verbose = $verbose
      salt.colorize = $colorize
      salt.bootstrap_options = "-X"
    end
    config.vm.provision "shell", path: "scripts/set_id.sh"
  end

end