#!/bin/bash
set -o xtrace

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=lean-sys.com

#
# Install Traefik
#
kubectl apply -f portainer.yaml
cat portainer-ingress.yaml | envsubst | kubectl apply -f -
