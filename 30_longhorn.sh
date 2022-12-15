#!/bin/bash
set -o xtrace

#
# Install Longhorn
#
curl https://raw.githubusercontent.com/longhorn/longhorn/v1.3.2/deploy/longhorn.yaml | sed -e 's/#- name: KUBELET_ROOT_DIR/- name: KUBELET_ROOT_DIR/g' -e 's$#  value: /var/lib/rancher/k3s/agent/kubelet$  value: /var/lib/kubelet$g' | kubectl apply -f -
watch kubectl get pods -A
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl get sc
