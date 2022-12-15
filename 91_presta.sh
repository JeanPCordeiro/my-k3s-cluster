#!/bin/bash
set -o xtrace

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=presta.lean-sys.com

#
# Install Traefik
#
kubectl create ns presta
cat prestashop.yaml | envsubst | kubectl apply -f - -n presta
