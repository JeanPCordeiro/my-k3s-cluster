#!/bin/bash
set -o xtrace

#
# to add a node
#

export MASTER1=vmi1053342.contaboserver.net
export MASTER2=vmi1026786.contaboserver.net
export MASTER3=vmi1026787.contaboserver.net

export MASTER_IP=10.0.0.3
export K3S_TOKEN=LeanSysK3sToken

NODE_EXTERNAL_IP=38.242.150.11
NODE_INTERNAL_IP=10.0.0.2
INTERNAL_INTERFACE=eth1

#

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.23.5+k3s1 K3S_TOKEN="${K3S_TOKEN}" sh -s server \
--server https://${MASTER_IP}:6443 \
--node-external-ip=${NODE_EXTERNAL_IP}  \
--node-ip=${NODE_INTERNAL_IP} \
--advertise-address=${NODE_INTERNAL_IP} \
--flannel-iface=${INTERNAL_INTERFACE}

kubectl get nodes -o wide

