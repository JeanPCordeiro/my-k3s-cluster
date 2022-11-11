#!/bin/bash
set -o xtrace

export DOMAIN=lean-sys.com
export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install cert manager
#
cat basic-auth-secret.yaml | envsubst | kubectl apply -f -
cat basic-auth-middleware.yaml | envsubst | kubectl apply -f -
cat traefik-ingressroute.yaml | envsubst | kubectl apply -f -
cat traefik-dashboard-ingress-basic-auth.yaml | envsubst | kubectl apply -f -

