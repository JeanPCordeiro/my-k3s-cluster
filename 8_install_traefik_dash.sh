#!/bin/bash
set -o xtrace

export DOMAIN=lean-sys.com
export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install cert manager
#
cat traefik-dashboard-service.yaml | envsubst | kubectl apply -f -
cat traefik-dashboard-ingress.yaml | envsubst | kubectl apply -f -

