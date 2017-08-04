# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.box_download_insecure = true
  config.vm.synced_folder "work/", "/home/vagrant/work"
  config.vm.define :'go-dev-box' do |m|
    m.vm.box = "bento/centos-7.3"

    # RabbitMQ
    m.vm.network 'forwarded_port', guest: 4369, host: 4369, auto_correct: true
    m.vm.network 'forwarded_port', guest: 5672, host: 5672, auto_correct: true
    m.vm.network 'forwarded_port', guest: 15672, host: 15672, auto_correct: true

    # ZooKeeper
    m.vm.network 'forwarded_port', guest: 2181, host: 2181, auto_correct: true

    # PostgreSQL
    m.vm.network 'forwarded_port', guest: 5432, host: 5432, auto_correct: true

    m.vm.hostname = 'go-dev-box'
    m.vm.provider :vmware_fusion do |v|
      #v.gui = true
      #v.linked_clone = false
      v.vmx['displayName'] = 'go-dev-box'
      v.vmx['memsize'] = 8192
      v.vmx['numvcpus'] = 2
    end

    # install puppet agent 1.3.4
    m.vm.provision :shell do |shell|
      shell.path = "scripts/install_puppet.sh"
    end

    # run puppet apply
    m.vm.provision :shell do |shell|
      shell.inline = "/opt/puppetlabs/bin/puppet apply --modulepath /vagrant/modules /vagrant/manifests/init.pp"
    end

    # install dlv command for golang debugging. Running as a seperate script to prevent being run with sudo
    m.vm.provision :shell do |shell|
      shell.path = "scripts/install_delve.ssh"
      shell.privileged = false
    end

    m.vm.provision :shell do |shell|
      shell.path = "scripts/create_bashrc.sh"
      shell.privileged = false
      shell.env = {
        'GH_USER' => ENV['GH_USER'],
        'GH_PASS' => ENV['GH_PASS'],
      }
    end

    # run commands needed to setup plugins directory
    m.vm.provision :shell do |shell|
      shell.path = "scripts/setup_dir.sh"
    end

    # run commands needed to setup bender
    m.vm.provision :shell do |shell|
      shell.path = "scripts/setup_service.sh"
      shell.privileged = false
    end
  end
end
