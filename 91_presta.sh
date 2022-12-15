#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=presta.lean-sys.com

#
# Install Prestashop
#
kubectl create ns presta
cat prestashop.yaml | envsubst | kubectl apply -f - -n presta
