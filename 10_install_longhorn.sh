#!/bin/bash
set -o xtrace

export DOMAIN=lean-sys.com
export EMAIL=jeanpierre.cordeiro@gmail.com

#
# Install cert manager
#
cat longhorn-ui-ingress.yaml | envsubst | kubectl apply -f -

