#!/bin/bash
set -o xtrace

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=lean-sys.com

#
# 
#
cat traefik-dashboard-service.yaml | envsubst | kubectl apply -f -
cat traefik-dashboard-tmp-ingress.yaml | envsubst | kubectl apply -f -
watch kubectl get pods -A
cat traefik-dashboard-tmp-ingress.yaml | envsubst | kubectl delete -f -
cat traefik-ingressroute-no-auth.yaml | envsubst | kubectl apply -f -
watch kubectl get pods -A

