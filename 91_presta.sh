#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install Prestashop LongHorn
#
export NAMESITE=presta-long
export DOMAIN=${NAMESITE}.lean-sys.com
kubectl create ns ${NAMESITE}
cat prestashop-long.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

#
# Install Prestashop OpenEBS
#
#export NAMESITE=presta-ebs
#export DOMAIN=${NAMESITE}.lean-sys.com
#kubectl create ns ${NAMESITE}
#cat prestashop-ebs.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

#
# Install Prestashop StorageOS
#
#export NAMESITE=presta-stor
#export DOMAIN=${NAMESITE}.lean-sys.com
#kubectl create ns ${NAMESITE}
#cat prestashop-stor.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

#
# Install Prestashop Local
#
#export NAMESITE=presta-local
#export DOMAIN=${NAMESITE}.lean-sys.com
#kubectl create ns ${NAMESITE}
#cat prestashop-local.yaml | envsubst | kubectl apply -f - -n ${NAMESITE}

