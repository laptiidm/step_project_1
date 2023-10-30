# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # >>>>>>first machine
  config.vm.define "supervisor" do |supervisor|
    supervisor.vm.box = "bento/ubuntu-22.04"
    supervisor.vm.hostname = "supervisor"
    supervisor.vm.network "public_network", type: "dhcp"

    supervisor.vm.provider "virtualbox" do |vb|
      # customize the amount of memory on the VM:
      vb.memory = "1024"
      vb.cpus = 1
    end

    # 
    supervisor.vm.provision "shell", path: "prometheus-install.sh"
    # 
    supervisor.vm.provision "shell", path: "grafana-install.sh"
    # 
    supervisor.vm.provision "shell", path: "alertmanager-install.sh"
  end
  
    # >>>>>>second machine
  config.vm.define "subordinate" do |subordinate|
    subordinate.vm.box = "bento/ubuntu-22.04"
    subordinate.vm.hostname = "subordinate"
    subordinate.vm.network "public_network", type: "dhcp"

    subordinate.vm.provider "virtualbox" do |vb|
      # customize the amount of memory on the VM (идентичные настройки)
      vb.memory = "1024"
      vb.cpus = 1
    end

    # 
    subordinate.vm.provision "shell", path: "mysql_server-install.sh"
    # 
    subordinate.vm.provision "shell", path: "prometheus_mysql_exporter-install.sh"
    # 
    subordinate.vm.provision "shell", path: "prometheus_node_exporter-install.sh"
  end
end











