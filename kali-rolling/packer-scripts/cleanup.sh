#!/bin/bash -eux

# Uninstall Ansible and remove PPA.
apt -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible

# Apt cleanup.
apt autoremove
apt update

# Disable root account over SSH
sed -i '/PermitRootLogin yes/d' /etc/ssh/sshd_config