#!/bin/bash
set -o xtrace

export MASTER=vmi1053342.contaboserver.net

#
# Install Kubectl & Helm
#
curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
brew install helm

#
# Get KUBECONGIG from MASTER
#
sudo scp root@${MASTER}:/etc/rancher/k3s/k3s.yaml /etc/.
sudo sed -i 's/127.0.0.1/${MASTER}/g' /etc/k3s.yaml
sudo chmod +r /etc/k3s.yaml
export KUBECONFIG=/etc/k3s.yaml
