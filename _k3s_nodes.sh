#!/bin/bash
set -o xtrace

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

#
# Install Kubectl & Helm
#
scp 22_k3s_node1.sh root@${MASTER2}:.
ssh root@${MASTER2} "TERM=xterm-256color ./22_k3s_node1.sh"

scp 23_k3s_node2.sh root@${MASTER3}:.
ssh root@${MASTER3} "TERM=xterm-256color ./23_k3s_node2.sh"
