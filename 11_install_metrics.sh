#!/bin/bash
set -o xtrace

export DOMAIN=lean-sys.com
export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install cert manager
#
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
helm repo update

# For new install
kubectl create ns monitoring
kubectl config set-context --current --namespace=monitoring
helm install prometheus-stack --version 35.3.1 -f prometheus-values.yaml prometheus-community/kube-prometheus-stack --kubeconfig /etc/rancher/k3s/k3s.yaml


cat alert-manager-ingress.yaml | envsubst | kubectl apply -f -
cat prometheus-ingress.yaml | envsubst | kubectl apply -f -
cat grafana-ingress.yaml | envsubst | kubectl apply -f -

cat traefik-service-monitor.yaml | envsubst | kubectl apply -f -
cat traefik-dashboard-service.yaml | envsubst | kubectl apply -f -
kubectl apply -f traefik-dashboard.yaml


