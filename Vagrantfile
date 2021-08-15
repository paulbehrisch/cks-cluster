# -*- mode: ruby -*-
# vi: set ft=ruby :
KUBE_MASTER_VM_ID = "kube-master"
KUBE_WORKER_VM_ID = "kube-worker"
IP_NW = "192.168.11."
IP_START=20

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.box_check_update = true

# Single Control-Plane node  
  config.vm.define "#{KUBE_MASTER_VM_ID}" do |node|
    node.vm.provider "virtualbox" do |vb|
      vb.name = "#{KUBE_MASTER_VM_ID}"
      vb.memory = 8192
      vb.cpus = 2
    end
    node.vm.hostname = "#{KUBE_MASTER_VM_ID}"
    node.vm.network :private_network, bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.11.10"

    node.vm.provision "bootstrap-master", :type => "shell", :path => "scripts/bootstrap.sh" do |s|
      s.args = ["enp0s8"]
    end
    node.vm.provision "init-k8s", type: "shell", :path => "scripts/install_master.sh" do |s|
      s.args = ["enp0s8"]
    end
    node.vm.provision "authorize-root", type: "shell", :path => "scripts/authorize-root.sh"
  end

# Worker node.
# In the CKS exam there is one master and one worker node for each of the provided clusters.
    config.vm.define "#{KUBE_WORKER_VM_ID}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "#{KUBE_WORKER_VM_ID}"
        vb.memory = 4096
        vb.cpus = 2
      end
      node.vm.hostname = "#{KUBE_WORKER_VM_ID}"
      node.vm.network :private_network, bridge: "en0: Wi-Fi (AirPort)", ip: IP_NW + "#{IP_START + 1}"

      node.vm.provision "bootstrap-master", :type => "shell", :path => "scripts/bootstrap.sh" do |s|
        s.args = ["enp0s8"]
      end
      node.vm.provision "install_worker", type: "shell", :path => "scripts/install_worker.sh"
      node.vm.provision "authorize-root", type: "shell", :path => "scripts/authorize-root.sh"
      node.vm.provision "join-cluster", type: "shell", :path => "scripts/kubeadm-join.sh"
    end
  end
