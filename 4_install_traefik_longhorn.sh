#!/bin/bash
set -o xtrace

#
# Install k3s
#
cat traefik-config.yaml | envsubst | kubectl apply -f -

#
# Install longhorn
#
curl https://raw.githubusercontent.com/longhorn/longhorn/v1.3.2/deploy/longhorn.yaml | sed -e 's/#- name: KUBELET_ROOT_DIR/- name: KUBELET_ROOT_DIR/g' -e 's$#  value: /var/lib/rancher/k3s/agent/kubelet$  value: /var/lib/kubelet$g' | kubectl apply -f -

