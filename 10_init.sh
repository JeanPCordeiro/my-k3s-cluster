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
