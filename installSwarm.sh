#!/bin/bash
apt-get install -y unzip
wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
unzip terraform_0.11.13_linux_amd64.zip
chmod +x terraform
mv terraform /usr/local/bin/terraform
ln -sfT /usr/local/bin/terraform /usr/bin/terraform

apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible
sed -i 's/#stdout_callback = skippy/stdout_callback = debug/g' /etc/ansible/ansible.cfg
apt-get install -y ssh

