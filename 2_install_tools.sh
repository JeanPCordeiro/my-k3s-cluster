#!/bin/bash
set -o xtrace

#
# Install Arkade, Helm and Kubectl autocomplete
#
curl -sLS https://dl.get-arkade.dev | sh
sudo cp arkade /usr/local/bin/arkade 
arkade get helm 
sudo cp ~/.arkade/bin/helm /usr/local/bin/
