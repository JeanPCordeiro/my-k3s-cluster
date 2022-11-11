#!/bin/bash
set -o xtrace

#
# Install cert manager
#
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.8.0/cert-manager.yaml

