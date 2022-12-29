#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=lean-sys.com

#
# 
#
kubectl create ns monitoring 

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus-stack --version 35.3.1 -f prometheus-values.yaml prometheus-community/kube-prometheus-stack -n monitoring

watch kubectl get pods -n monitoring

cat alert-manager-ingress.yaml | envsubst | kubectl apply -f - -n monitoring
cat prometheus-ingress.yaml | envsubst | kubectl apply -f - -n monitoring
cat grafana-ingress.yaml | envsubst | kubectl apply -f - -n monitoring
