#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=lean-sys.com

#
# 
#
cat basic-auth-secret.yaml | envsubst | kubectl apply -f -
cat basic-auth-middleware.yaml | envsubst | kubectl apply -f -
cat traefik-ingressroute.yaml | envsubst | kubectl apply -f -
cat traefik-dashboard-ingress-basic-auth.yaml | envsubst | kubectl apply -f -

cat longhorn-ui-ingress.yaml | envsubst | kubectl apply -f -
