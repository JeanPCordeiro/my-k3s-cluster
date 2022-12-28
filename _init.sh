#!/bin/bash
set -o xtrace

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

#
# Install Kubectl & Helm
#
scp 10_init.sh root@${MASTER1}:.
ssh root@${MASTER1}

scp 10_init.sh root@${MASTER2}:.
ssh root@${MASTER2} 

scp 10_init.sh root@${MASTER3}:.
ssh root@${MASTER3} 