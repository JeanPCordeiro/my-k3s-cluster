#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=lean-sys.com

#
# Install Portainer
#
kubectl apply -f portainer.yaml
cat portainer-ingress.yaml | envsubst | kubectl apply -f -
