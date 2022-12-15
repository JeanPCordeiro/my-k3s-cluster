#!/bin/bash
set -o xtrace

export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install Cert Manager
#
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml
watch kubectl get pods -A

cat letsencrypt-prod.yaml | envsubst | kubectl apply -f -
watch kubectl get pods -A
cat traefik-https-redirect-middleware.yaml | envsubst | kubectl apply -f -
watch kubectl get pods -A


