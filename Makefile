ifndef VERBOSE
.SILENT:
endif

export MASTER1 ?= vmi1053342.contaboserver.net
export MASTER2 ?= vmi1026786.contaboserver.net
export MASTER3 ?= vmi1026787.contaboserver.net

export EMAIL ?= jeanpierre.cordeiro@gmail.com
export DOMAIN ?= lean-sys.com

info:
	printf "\033c"
	echo 
	echo 
	echo " \033[0;32m k3s Cluster and Stack Install\033[0m"
	echo 
	echo "Usage" 
	echo "	make \033[0;33mset_ssh\033[0m"
	echo "	make test_ssh"
	echo "	make test_ansible"
	echo
	echo

all : ssh_set ssh_test ansible_test k3s_install k3s_config k3s_longhorn k3s_certlets k3s_traefik k3s_longhorn k3s_monitor k3s_portainer

ssh_set:
	echo 'StrictHostKeyChecking no' > ~/.ssh/config
	rm -f ~/.ssh/known_hosts
	rm -f ~/.ssh/id_rsa*
	ls ~/.ssh/
	ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
	ssh-copy-id root@${MASTER1}
	ssh-copy-id root@${MASTER2}
	ssh-copy-id root@${MASTER3}	

ssh_test:
	ssh root@${MASTER1} uptime
	ssh root@${MASTER2} uptime
	ssh root@${MASTER3} uptime


ansible_test:
	ansible -u root -i Inventory/hosts.ini all -m ping

k3s_uninstall:
	ansible-playbook -u root -i Inventory/hosts.ini UnInstall.yaml 

k3s_install:
	ansible-playbook -u root -i Inventory/hosts.ini Install.yaml

k3s_config:
	scp root@${MASTER1}:/etc/rancher/k3s/k3s.yaml _k3s.yaml
	sudo sed -i 's/127.0.0.1/${MASTER1}/g' _k3s.yaml
	cat _k3s.yaml | envsubst > k3s.yaml
	rm _k3s.yaml
	sudo mv k3s.yaml /etc/k3s.yaml
	sudo chmod +r /etc/k3s.yaml
	rm -fr ~/.kube
	mkdir ~/.kube 
	cp /etc/k3s.yaml ~/.kube/config

k3s_longhorn:
	kubectl wait deployment -n kube-system traefik  --for condition=Available=True --timeout=180s
	ansible-playbook -i Inventory/hosts.ini k3s_longhorn.yaml
	kubectl wait deployment -n longhorn-system longhorn-driver-deployer  --for condition=Available=True --timeout=180s
	kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

k3s_certlets:
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml
	kubectl wait deployment -n cert-manager cert-manager-webhook  --for condition=Available=True --timeout=180s
	cat letsencrypt-prod.yaml | envsubst '$${EMAIL}' | kubectl apply -f -
	cat traefik-https-redirect-middleware.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	kubectl apply -f whoami-deployment.yaml 
	kubectl apply -f whoami-service.yaml
	cat whoami-ingress-tls.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -

k3s_traefik:
	cat traefik-dashboard-service.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	cat traefik-dashboard-tmp-ingress.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	sleep 60
	cat traefik-dashboard-tmp-ingress.yaml | envsubst '$${DOMAIN}' | kubectl delete -f -
	cat traefik-ingressroute-no-auth.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	cat basic-auth-secret.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	cat basic-auth-middleware.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	cat traefik-dashboard-ingress-basic-auth.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	cat longhorn-ui-ingress.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -

k3s_monitor:
	kubectl apply -f monitor_ns.yaml
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update
	helm install prometheus-stack --version 35.3.1 -f prometheus-values.yaml prometheus-community/kube-prometheus-stack -n monitoring
	kubectl wait deployment -n monitoring prometheus-stack-kube-state-metrics  --for condition=Available=True --timeout=180s
	cat alert-manager-ingress.yaml | envsubst '$${DOMAIN}' | kubectl apply -f - -n monitoring
	cat prometheus-ingress.yaml | envsubst '$${DOMAIN}' | kubectl apply -f - -n monitoring
	cat grafana-ingress.yaml | envsubst '$${DOMAIN}' | kubectl apply -f - -n monitoring

k3s_portainer:
	kubectl apply -f portainer.yaml
	cat portainer-ingress.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -
	kubectl wait deployment -n portainer portainer  --for condition=Available=True --timeout=240s

k3s_drools:
	cat drools.yaml | envsubst '$${DOMAIN}' | kubectl apply -f -

drools_test:
	echo "List DMN"
	curl -u 'kieserver:kieserver1!' -H "accept: application/json" -X GET "https://kie-server.drools.lean-sys.com/kie-server/services/rest/server/containers/traffic-violation_1.0.0-SNAPSHOT/dmn"
	echo
	echo "Execute Model"
	curl -u 'kieserver:kieserver1!' -H "accept: application/json" -H "content-type: application/json" -X POST "https://kie-server.drools.lean-sys.com/kie-server/services/rest/server/containers/traffic-violation_1.0.0-SNAPSHOT/dmn" -d "{ \"model-namespace\" : \"https://kiegroup.org/dmn/_03DAAFDA-EF0E-492C-A752-7946B9646137\", \"model-name\" : \"Traffic Violation\", \"dmn-context\" : {\"Driver\" : {\"Points\" : 10}, \"Violation\" : {\"Type\" : \"speed\", \"Actual Speed\" : 135, \"Speed Limit\" : 100}}}"
	echo

che_install:
	bash <(curl -sL  https://www.eclipse.org/che/chectl/)

newrelic_uninstall:
	helmcurrent=$(helm list -n newrelic | tail -1 | awk '{ print $1 }')
	helm uninstall "$helmcurrent" -n newrelic
	kubectl delete -f https://raw.githubusercontent.com/pixie-labs/pixie/main/k8s/vizier_deps/base/nats/nats_crd.yaml
	kubectl delete -f https://raw.githubusercontent.com/pixie-labs/pixie/main/k8s/operator/crd/base/px.dev_viziers.yaml
	kubectl delete -f https://raw.githubusercontent.com/pixie-labs/pixie/main/k8s/operator/helm/crds/olm_crd.yaml
	kubectl delete pods,services,deployments,statefulsets,secrets,clusterroles,clusterrolebindings -l app=pl-monitoring
	kubectl delete pods,services,deployments,statefulsets,secrets,clusterroles,clusterrolebindings -l component=vizier
	kubectl delete namespace newrelic

kc_install:
	kubectl create ns keycloak
	kubectl apply -f kc_config.yaml
	kubectl apply -f kc_secrets.yaml
	kubectl apply -f kc_pvc.yaml
	kubectl apply -f kc_deploy.yaml
	kubectl apply -f kc_service.yaml
	kubectl apply -f kc_ingress.yaml

kc_config:
	kubectl exec deploy/keycloak -n keycloak -- bash -c \
    "/opt/jboss/keycloak/bin/kcadm.sh config credentials \
        --server http://keycloak.sys.lean-sys.com \
        --realm master \
        --user admin@keycloak  \
        --password @Lnss9700!! && \
    /opt/jboss/keycloak/bin/kcadm.sh create realms \
        -s realm='che' \
        -s displayName='che' \
        -s enabled=true \
        -s registrationAllowed=false \
        -s resetPasswordAllowed=true && \
    /opt/jboss/keycloak/bin/kcadm.sh create clients \
        -r 'che' \
        -s clientId=k8s-client \
        -s id=k8s-client \
        -s redirectUris='[\"*\"]' \
        -s directAccessGrantsEnabled=true \
        -s secret=eclipse-che && \
    /opt/jboss/keycloak/bin/kcadm.sh create users \
        -r 'che' \
        -s username=test \
        -s email=\"test@test.com\" \
        -s enabled=true \
        -s emailVerified=true &&  \
    /opt/jboss/keycloak/bin/kcadm.sh set-password \
        -r 'che' \
        --username test \
        --new-password test"

