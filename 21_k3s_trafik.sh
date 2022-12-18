#!/bin/bash
set -o xtrace

export INTERNAL_INTERFACE=eth1
export NODE_EXTERNAL_IP=45.88.223.169
export NODE_INTERNAL_IP=10.0.0.3

#
# Install K3S
#

cat ./traefik-config.yaml | envsubst | kubectl apply -f -
watch kubectl get pods -A
