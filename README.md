# my-k3s-cluster

[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/from-referrer/)


A full k3s kubernetes cluster stack

Command to install k3s :
```bash
ansible-playbook -u root -i Inventory/hosts.ini Install.yaml
```

Command to uninstall k3s :
```bash
ansible-playbook -u root -i Inventory/hosts.ini UnInstall.yaml 
```

Command to install the stack  :
```bash
ansible-playbook -i Inventory/hosts.ini Stack.yaml