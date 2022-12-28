#!/bin/bash
set -o xtrace

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

#
# Install Kubectl & Helm
#
scp 25_disk.sh root@${MASTER1}:.
scp losetup.service root@${MASTER1}:.
ssh root@${MASTER1} "chmod +x ./25_disk.sh ; ./25_disk.sh"

scp 25_disk.sh root@${MASTER2}:.
scp losetup.service root@${MASTER2}:.
ssh root@${MASTER2} "chmod +x ./25_disk.sh ; ./25_disk.sh"

scp 25_disk.sh root@${MASTER3}:.
scp losetup.service root@${MASTER3}:.
ssh root@${MASTER3} "chmod +x ./25_disk.sh ; ./25_disk.sh"