#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install Prestashop LongHorn
#
export NAMESITE=presta1
export DOMAIN=${NAMESITE}.lean-sys.com
kubectl create ns ${NAMESITE}
cat prestashop.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

#
# Install Prestashop Local
#
export NAMESITE=presta2
export DOMAIN=${NAMESITE}.lean-sys.com
kubectl create ns ${NAMESITE}
cat prestashop-local.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

