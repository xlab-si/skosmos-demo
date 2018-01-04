SSH_PRIVATE_KEY = $(HOME)/.ssh/id_rsa
SSH_USER = root

create:
	@echo "Not implemented"

delete:
	@echo "Not implemented"

ssh:
	@ssh -i $(SSH_PRIVATE_KEY) $(SSH_USER)@10.10.43.227
