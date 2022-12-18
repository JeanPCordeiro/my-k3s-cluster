#!/bin/bash
set -o xtrace

export INTERNAL_INTERFACE=eth1
export NODE_EXTERNAL_IP=45.88.223.169
export NODE_INTERNAL_IP=10.0.0.3

#
# Install K3S
#

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.23.5+k3s1 K3S_TOKEN=LeanSysK3sToken sh -s server \
--cluster-init \
--node-external-ip=${NODE_EXTERNAL_IP}  \
--node-ip=${NODE_INTERNAL_IP} \
--advertise-address=${NODE_INTERNAL_IP} \
--flannel-iface=${INTERNAL_INTERFACE}

watch kubectl get nodes -o wide
watch kubectl get pods -A
