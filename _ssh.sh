#!/bin/bash
set -o xtrace

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

#
# Set PasswordLess
#

rm ~/.ssh/known_hosts

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

ssh-copy-id root@${MASTER1}
ssh-copy-id root@${MASTER2}
ssh-copy-id root@${MASTER3}
