#!/bin/bash
set -o xtrace

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

#
# Install Kubectl & Helm
#
ssh root@${MASTER3} k3s-uninstall.sh
ssh root@${MASTER2} k3s-uninstall.sh
ssh root@${MASTER1} k3s-uninstall.sh
