# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos/7"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.34.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.provision "file", source:"skosmos", destination:"skosmos"
  config.vm.provision "file", source:"apache-jena-fuseki-2.3.0.tar.gz", destination:"fuseki.tar.gz"
  config.vm.provision "file", source:"fuseki.service", destination:"fuseki.service"
  config.vm.provision "file", source:"skosmos.ttl", destination:"skosmos.ttl"
  config.vm.provision "file", source:"unescothes.ttl", destination:"unescothes.ttl"
  config.vm.provision "file", source:"stw.ttl", destination:"stw.ttl"
  config.vm.provision "file", source:"skosmos.conf", destination:"skosmos.conf"
  config.vm.provision "shell", inline: <<-SHELL
    setenforce 0
    chmod +x /home/vagrant
    yum install -y httpd
    yum install -y git
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    yum install -y php56
    yum install -y php56-php-mbstring
    yum install -y php56-php.x86_64
    yum install -y java
    yum install -y ruby
    sed -i -e 's/;date\.timezone\s=/date.timezone="Europe\/Ljubljana"/' /opt/remi/php56/root/etc/php.ini
    mv /home/vagrant/fuseki.service /etc/systemd/system/
    ln -s /usr/bin/php56 /usr/bin/php
    ln -s /home/vagrant/skosmos /var/www/html/skosmos
    echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf
    mkdir -p /etc/httpd/sites-enabled
    mv /home/vagrant/skosmos.conf /etc/httpd/sites-enabled/skosmos.conf
    systemctl start httpd
    setsebool -P httpd_can_network_connect on
    mkdir -p /var/lib/fuseki/{backups,databases,system,system_files}
    mkdir -p /var/log/fuseki
    mkdir -p /etc/fuseki
    mkdir -p /etc/fuseki/configuration
    tar xzf /home/vagrant/fuseki.tar.gz
    ln -s /home/vagrant/apache-jena-fuseki-2.3.0 /opt/fuseki
    ln -s /var/lib/fuseki/backups /etc/fuseki/backups
    ln -s /var/lib/fuseki/databases /etc/fuseki/databases
    ln -s /var/lib/fuseki/system /etc/fuseki/system
    ln -s /var/lib/fuseki/system_files /etc/fuseki/system_files
    ln -s /var/log/fuseki /etc/fuseki/logs
    systemctl start fuseki
    systemctl enable fuseki
    while ! curl --output /dev/null --silent --fail --data "dbName=skosmos&dbType=tdb" http://localhost:3030/$/datasets/; do sleep 1; done;
    systemctl stop fuseki
    mv /home/vagrant/skosmos.ttl /etc/fuseki/configuration/skosmos.ttl
    systemctl start fuseki
    while ! curl --output /dev/null --silent --fail http://localhost:3030; do sleep 1; done;
    /opt/fuseki/bin/s-put http://localhost:3030/skosmos/data http://zbw.eu/stw/ /home/vagrant/stw.ttl
    /opt/fuseki/bin/s-put http://localhost:3030/skosmos/data http://skos.um.es/unescothes/ /home/vagrant/unescothes.ttl
  SHELL

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
