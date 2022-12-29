#!/bin/bash
set -o xtrace

export KUBECONFIG=/etc/k3s.yaml

#
# Install PortWorx
#
kubectl label nodes vmi1053342 vmi1026786 vmi1026787 px/metadata-node=true
kubectl apply -f 'https://install.portworx.com/2.11?comp=pxoperator'
watch kubectl get pods -A
kubectl apply -f 'https://install.portworx.com/2.11?operator=true&mc=false&oem=esse&user=1bb42bc1-77ff-4fa3-bb41-d05fd32822d3&b=true&s=%2Fdev%2Floop0&m=eth1&d=eth1&c=px-cluster-173135a6-4396-4f35-b4ce-d9c54ce77392&stork=true&csi=true&mon=true&tel=false&st=k8s&promop=true'
watch kubectl get pods -A

kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageclass px-csi-replicated -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl get sc

watch kubectl -n kube-system get storagenodes -l name=portworx
