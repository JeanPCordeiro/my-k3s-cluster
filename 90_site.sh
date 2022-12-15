#!/bin/bash
set -o xtrace

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=site.lean-sys.com

#
# Install Traefik
#
kubectl create ns website
cat wordpress.yaml | envsubst | kubectl apply -f - -n website
