# Skosmos deploy script

Ansible with make wrapper for deploying Skosmos  
Instructions in Slovenian available [here](README_si.md)

## Prerequisites

Minimum required versions:
- VirtualBox 5.1.26 (only for `vagrant` environment)
- Vagrant 1.9.8 (only for `vagrant` environment)
- Ansible 2.4.1.0

## Installation

### Environment argument

The `ENVIRONMENT` variable defines the deploy target, the default being `vagrant`,
which sets up a local VM. `os-xlab` (XLABs Openstack) is the other option. The variable
is set either with an  `export` export command, or as a prefix to a make command.
```
export ENVIRONMENT=os-xlab
make ...
# or
ENVIRONMENT=os-xlab make ...
```
The `os-xlab` environment needs ssh access (both for remote administration and running Ansible),
via an ssh key at `~/.ssh/id_rsa`, if your key is in a different location, it must be specified in
`environments/os-xlab/os-xlab.mk`.

### Make targets

- `create`: creates a VM (not implemented in `os-xlab` environment)
- `delete`: destroys VM (not implemented in `os-xlab` environment)
- `ssh`: ssh access to VM
- `provision`: runs Ansible deploy scripts

### Local deploy

Vagrant creates a VM with the IP `192.168.34.10`. The IP is changeable in the file
`environments/vagrant/Vagrantfile`.

## Use

After a successful deployment, Skosmos is available at `http://<ip or FQDN>/skosmos`
