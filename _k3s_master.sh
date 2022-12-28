#!/bin/bash
set -o xtrace

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

#
# Install Kubectl & Helm
#
scp 20_k3s_master.sh root@${MASTER1}:.
ssh root@${MASTER1} "TERM=xterm-256color ./20_k3s_master.sh"
