#!/bin/bash
set -o xtrace

#
# Upgrade system
#
apt update
apt upgrade -y

#
# Install fail2ban
#
apt install fail2ban -y
fail2ban-client status
fail2ban-client status sshd

#
# Add user leansys
#
adduser leansys
usermod -aG sudo leansys

#
# Set Firewall
#
#cp iptables.conf /etc/iptables.conf
#iptables-restore -n /etc/iptables.conf
#cp iptables.service /etc/systemd/system/iptables.service
#systemctl enable --now iptables

#
# Install Net Tools and XFS
#
apt install net-tools iftop -y
apt install xfsprogs -y
apt install open-iscsi -y
apt install iscsiadm -y
apt install wireguard -y
apt install -y jq
apt install -y nfs-common
