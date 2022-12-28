#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

#
# Install PortWorx
#
kubectl label nodes vmi1053342 vmi1026786 vmi1026787 px/metadata-node=true
kubectl apply -f 'https://install.portworx.com/2.11?comp=pxoperator'
watch kubectl get pods
kubectl apply -f 'https://install.portworx.com/2.11?operator=true&mc=false&oem=esse&user=1bb42bc1-77ff-4fa3-bb41-d05fd32822d3&b=true&s=%2Fdev%2Floop0&m=eth1&d=eth1&c=px-cluster-6f0741c6-653f-4686-a44b-5566a2e6f58f&stork=true&csi=true&mon=true&tel=false&st=k8s&promop=true'
watch kubectl get pods

kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageclass px-csi-replicated -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl get sc
