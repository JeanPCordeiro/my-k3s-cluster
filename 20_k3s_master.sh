#!/bin/bash
set -o xtrace

#
# Install K3S
#
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.23.5+k3s1 K3S_TOKEN=LeanSysK3sToken INSTALL_K3S_EXEC="--tls-san vmi1053342.contaboserver.net" sh -s - server --cluster-init
watch kubectl get nodes
watch kubectl get pods -A

cat ./traefik-config.yaml | envsubst | kubectl apply -f -
watch kubectl get pods -A
