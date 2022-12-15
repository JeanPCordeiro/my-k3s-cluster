#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=site.lean-sys.com

#
# Install Wordpress
#
kubectl create ns website
cat wordpress.yaml | envsubst | kubectl apply -f - -n website
