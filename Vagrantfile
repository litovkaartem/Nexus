# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config| #Nexus01
  config.vm.define "nexus01" do |nexus|
    nexus.vm.box = "ubuntu/focal64"
    nexus.vm.hostname = "nexus01"
    nexus.vm.network "private_network", ip: "192.168.20.138"
    
    nexus.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
      vb.name = "nexus01"
    end
    
    # Папки с конфигами docker-compose.yml и nginx.conf лежат в одной директории с vagrantfile
    nexus.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    
    # Получение сертификатов
    nexus.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y wget libnss3-tools
      wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O /usr/local/bin/mkcert
      chmod +x /usr/local/bin/mkcert
      mkcert -install
      cd /vagrant
      mkcert 192.168.20.138
    SHELL
    
    # Установка Docker
    nexus.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install ca-certificates curl
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
      chmod a+r /etc/apt/keyrings/docker.asc
      echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
      apt-get update
      apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

      cd /vagrant
      docker-compose up -d
    SHELL
  end

  config.vm.define "app01" do |django| #app01
    django.vm.box = "ubuntu/jammy64"
    django.vm.hostname = "app01"
    django.vm.network "private_network", ip: "192.168.20.139"
    
    django.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "app01"
    end
    
    django.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    
    # Установка зависимостей для Django
    django.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y python3-pip python3-dev libpq-dev python3-venv
      
      cd /vagrant
      git clone https://gitfront.io/r/deusops/cgQdYMe4m1V1/django-girls-wo-docker/
      cd django-girls-wo-docker/
      python -m venv venv
      source venv/bin/activate
      pip install -r requirements.txt
      python manage.py migrate blog
      python manage.py migrate
      python manage.py runserver 0.0.0.0:8000
    SHELL
  end
end
