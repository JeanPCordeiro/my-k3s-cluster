#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export NAMESITE=site

export EMAIL=jeanpierre.cordeiro@gmail.com
#export DOMAIN=${NAMESITE}.lean-sys.com
export DOMAIN=lean-sys.com

#
# Install Wordpress
#
kubectl create ns ${NAMESITE}
#cat wordpress-local.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}
cat wordpress.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}
