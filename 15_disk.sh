#!/bin/bash
set -o xtrace

#
# to add a node
#

fallocate -l 300G /disk300G.img
losetup -a
cp losetup.service /etc/systemd/system/losetup.service
systemctl enable --now losetup
losetup -a
