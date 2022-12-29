#!/bin/bash
set -o xtrace

export MASTER=vmi1053342.contaboserver.net

#
# Get KUBECONGIG from MASTER
#
scp root@${MASTER}:/etc/rancher/k3s/k3s.yaml _k3s.yaml
sudo sed -i 's/127.0.0.1/${MASTER}/g' _k3s.yaml
cat _k3s.yaml | envsubst > k3s.yaml
rm _k3s.yaml
sudo mv k3s.yaml /etc/k3s.yaml
sudo chmod +r /etc/k3s.yaml
export KUBECONFIG=/etc/k3s.yaml
