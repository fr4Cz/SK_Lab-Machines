#!/bin/bash -eux

# Add packages
apt-get update
apt-get -y install python3-pip htop nload gedit dconf-cli bloodhound powershell gss-ntlmssp
pip3 install impacket
gem install evil-winrm 

# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Change Shell from bash to zsh.
sed -i "/vagrant/s/bash/zsh/g" /etc/passwd

# Create static IP for eth0
cat << EOF > /etc/network/interfaces 
auto lo eth0
iface lo inet loopback
iface eth0 inet static
	address 10.0.2.15
	netmask 255.255.255.0
	gateway 10.0.2.2
EOF
