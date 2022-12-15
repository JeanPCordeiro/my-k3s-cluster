#!/bin/bash
set -o xtrace

export MASTER=vmi1053342.contaboserver.net

#
# Install Kubectl & Helm
#
curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo rm kubectl
brew install helm

sudo apt update
sudo apt-get install gettext-base -y

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
