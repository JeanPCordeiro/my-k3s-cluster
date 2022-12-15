#!/bin/bash
set -o xtrace

#
# to add a node
#

export MASTER=vmi1053342.contaboserver.net
export TOKEN=LeanSysK3sToken

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.23.13+k3s1 K3S_TOKEN=${TOKEN} sh -s - server --server https://${MASTER}:6443 --disable=traefik
kubectl get nodes
