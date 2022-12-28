#!/bin/bash
set -o xtrace

#
# Add User onebuck
#
adduser leansys
usermod -aG sudo leansys

#
# Install Fail2Ban, Net-Tools & iSCSI
#
apt update -y
apt install -y fail2ban
fail2ban-client status sshd
fail2ban-client status sshd
apt install -y net-tools
apt install -y iftop
apt install -y open-iscsi
apt install -y apache2-utils

systemctl enable --now iscsid

systemctl disable snapd.service
systemctl disable snapd.socket
systemctl disable snapd.seeded.service
snap list
snap remove lxd
snap remove core20
snap remove snapd
rm -rf /var/cache/snapd/
apt autoremove --purge snapd
rm -rf ~/snap

reboot