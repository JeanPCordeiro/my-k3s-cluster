MASTER1 ?=vmi1053342.contaboserver.net
MASTER2 ?=vmi1026786.contaboserver.net
MASTER3 ?=vmi1026787.contaboserver.net

set_ssh:
	echo 'StrictHostKeyChecking no' > ~/.ssh/config
	rm -f ~/.ssh/known_hosts
	rm -f ~/.ssh/id_rsa*
	ls ~/.ssh/
	ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
	ssh-copy-id root@${MASTER1}
	ssh-copy-id root@${MASTER2}
	ssh-copy-id root@${MASTER3}	

test_ssh:
	ssh root@${MASTER1} uname -a
	ssh root@${MASTER2} uname -a
	ssh root@${MASTER3} uname -a

test_ansible:
	ansible -u root -i Inventory/hosts.ini all -m ping

k3s_uninstall:
	ansible-playbook -u root -i Inventory/hosts.ini UnInstall.yaml 

k3s_install:
	ansible-playbook -u root -i Inventory/hosts.ini Install.yaml

k3s_longhorn:
	ansible-playbook -i Inventory/hosts.ini k3s_longhorn.yaml
	kubectl wait deployment -n longhorn-system longhorn-driver-deployer  --for condition=Available=True --timeout=180s
	kubectl wait deployment -n longhorn-system csi-provisioner  --for condition=Available=True --timeout=180s

k3s_getconfig:
	scp root@${MASTER1}:/etc/rancher/k3s/k3s.yaml _k3s.yaml
	sudo sed -i 's/127.0.0.1/${MASTER1}/g' _k3s.yaml
	cat _k3s.yaml | envsubst > k3s.yaml
	rm _k3s.yaml
	sudo mv k3s.yaml /etc/k3s.yaml
	sudo chmod +r /etc/k3s.yaml
	rm -fr ~/.kube
	mkdir ~/.kube 
	cp /etc/k3s.yaml ~/.kube/config