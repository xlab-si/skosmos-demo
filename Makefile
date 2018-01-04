ENVIRONMENT ?= vagrant
DEPLOY_DIR = $(PWD)
ENV_DIR = $(DEPLOY_DIR)/environments/$(ENVIRONMENT)
ANSIBLE_DIR = $(DEPLOY_DIR)/ansible

include $(PWD)/environments/$(ENVIRONMENT)/$(ENVIRONMENT).mk

ANSIBLE_ARGS = -i $(ENV_DIR)/inventory \
							 --private-key=$(SSH_PRIVATE_KEY) \
							 -e ansible_dir=$(ANSIBLE_DIR) \
							 -u $(SSH_USER)

provision:
	@ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook $(ANSIBLE_ARGS) $(ANSIBLE_DIR)/provision.yml

PROVISION_TARGETS=$(notdir $(basename $(wildcard $(ANSIBLE_DIR)/provision-*.yml)))
$(PROVISION_TARGETS):
	@ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook $(ANSIBLE_ARGS) $(ANSIBLE_DIR)/$@.yml
