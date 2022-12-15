#!/bin/bash
set -o xtrace

sudo scp root@vmi1053342.contaboserver.net:/etc/rancher/k3s/k3s.yaml /etc/.
sudo sed -i 's/127.0.0.1/vmi1053342.contaboserver.net/g' /etc/k3s.yaml
sudo chmod +r /etc/k3s.yaml
export KUBECONFIG=/etc/k3s.yaml
