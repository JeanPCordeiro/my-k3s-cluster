MASTER1 ?=vmi1053342.contaboserver.net
MASTER2 ?=vmi1026786.contaboserver.net
MASTER3 ?=vmi1026787.contaboserver.net

ssh:
	rm -f ~/.ssh/known_hosts
	ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
	ssh-copy-id root@${MASTER1}
	ssh-copy-id root@${MASTER2}
	ssh-copy-id root@${MASTER3}	

test_ssh:
	ssh root@${MASTER1} uname -a
	ssh root@${MASTER2} uname -a
	ssh root@${MASTER3} uname -a
