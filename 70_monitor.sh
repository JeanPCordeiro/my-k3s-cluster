#!/bin/bash
set -o xtrace

export EMAIL=jeanpierre.cordeiro@gmail.com
export DOMAIN=lean-sys.com

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
#
# 
#
kubectl create ns monitoring 

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
helm repo update
helm install prometheus-stack --version 35.3.1 -f prometheus-values.yaml prometheus-community/kube-prometheus-stack -n monitoring

watch kubectl get pods -A

cat alert-manager-ingress.yaml | envsubst | kubectl apply -f - -n monitoring
cat prometheus-ingress.yaml | envsubst | kubectl apply -f - -n monitoring
cat grafana-ingress.yaml | envsubst | kubectl apply -f - -n monitoring
#cat traefik-service-monitor.yaml | envsubst | kubectl apply -f -
#cat traefik-dashboard-service.yaml | envsubst | kubectl apply -f -
#kubectl apply -f traefik-dashboard.yaml -n monitoring


#helm repo add grafana https://grafana.github.io/helm-charts && \
#helm repo update && \
#helm upgrade --install loki grafana/loki-stack -n monitoring


