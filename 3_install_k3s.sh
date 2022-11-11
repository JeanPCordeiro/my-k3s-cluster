#!/bin/bash
set -o xtrace

#
# Install k3s
#
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.23.5+k3s1 sh -s server \
--cluster-init \
--flannel-backend=wireguard \
--write-kubeconfig-mode 644 

