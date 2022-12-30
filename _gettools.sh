#!/bin/bash
set -o xtrace

#
# Install Kubectl & Helm
#
curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo rm kubectl
brew install helm

sudo apt update
sudo apt-get install gettext-base -y

pip install --user ansible
pip install --user kubernetes
pip install --user python-dateutil
ansible-galaxy collection install kubernetes.core

