#!/bin/bash
set -o xtrace

#
# to add a node
#

fallocate -l 150G /disk150G.img
losetup -a
cp losetup.service /etc/systemd/system/losetup.service
systemctl enable --now losetup
losetup -a
