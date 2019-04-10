#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

export LC_ALL=C

# install python-minimal
apt-get update
apt-get install python-minimal -y

# install docker
echo "Docker installing..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
echo "Docker installed..."

echo "Docker starting..."
usermod -aG docker ${whoami}
systemctl enable docker
systemctl start docker

# dcs install
echo "DCS installing..."
curl -sL bit.ly/ralf_dcs -o ./dcs
chmod 755 ./dcs
mv ./dcs /usr/bin/dcs
echo "DCS installed..."

echo "Docker-compose installing..."
#curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -sfT /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
echo "Docker-compose installed..."

echo "Docker-machine installing..."
#curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine
#chmod +x /tmp/docker-machine
#cp /tmp/docker-machine /usr/local/bin/docker-machine
curl -L https://github.com/docker/machine/releases/download/v0.16.0/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
install /tmp/docker-machine /usr/local/bin/docker-machine

echo "Docker-machine installed..."


