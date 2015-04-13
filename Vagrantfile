# -*- mode: ruby -*-
# vi: set ft=ruby : 

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/centos65"
  config.vm.box_url = "boxcutter/centos65"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo yum install -y \
        ruby \
        ruby-devel \
        rubygems \
        make \
        gcc \
        pcre-devel \
        zlib-devel \
        rpm-build

    gem install fpm --no-rdoc --no-ri
  SHELL
end
