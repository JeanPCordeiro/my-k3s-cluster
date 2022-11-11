#!/bin/bash
set -o xtrace

export K3S_TOKEN=K10b1698c844a8eaecc463cd5ab33f7c27c56800422d2ab3b72d9256ae6d263d0e8::server:d7b31faeb20ef79dbff485c9615ce134
export MASTER_IP=45.88.223.169

#
# Install k3s nodes
#
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.23.5+k3s1 K3S_TOKEN="${K3S_TOKEN}" sh -s server \
--flannel-backend=wireguard \
--server https://${MASTER_IP}:6443

