#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install Prestashop LongHorn
#
export NAMESITE=presta3
export DOMAIN=${NAMESITE}.lean-sys.com
kubectl create ns ${NAMESITE}
cat prestashop.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

#
# Install Prestashop Local
#
export NAMESITE=presta4
export DOMAIN=${NAMESITE}.lean-sys.com
kubectl create ns ${NAMESITE}
cat prestashop-local.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

