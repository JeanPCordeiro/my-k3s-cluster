#!/bin/bash
set -o xtrace

export DOMAIN=lean-sys.com
export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install cert manager
#
kubectl apply -f ./whoami/whoami-deployment.yaml 
kubectl apply -f ./whoami/whoami-service.yaml
kubectl apply -f ./whoami/whoami-ingress.yaml


cat letsencrypt-prod.yaml | envsubst | kubectl apply -f -
cat traefik-https-redirect-middleware.yaml | envsubst | kubectl apply -f -
cat ./whoami/whoami-ingress-tls.yaml | envsubst | kubectl apply -f -
