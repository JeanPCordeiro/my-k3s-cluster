#!/bin/bash
set -o xtrace

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

#
# Install Kubectl & Helm
#

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

scp ~/.ssh/id_rsa.pub root@${MASTER1}:./
scp ~/.ssh/id_rsa.pub root@${MASTER2}:./
scp ~/.ssh/id_rsa.pub root@${MASTER3}:./

ssh root@${MASTER1} "mkdir .ssh ; cp id_rsa.pub .ssh/authorized_keys"
ssh root@${MASTER2} "mkdir .ssh ; cp id_rsa.pub .ssh/authorized_keys"
ssh root@${MASTER3} "mkdir .ssh ; cp id_rsa.pub .ssh/authorized_keys"
