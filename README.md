# VDI Master Automation with Packer and Ansible 
This project uses Packer to create a Windows VM in VMware vSphere and configures it so Ansible can be used to further customize and install software on the operating system.

This speeds up the process of creating highly customized Master / Golden Images for VDI puposes.

## Setup VM
-  Install Ubuntu server
-  Install Packer and Ansible
-  Install `sudo apt-get install -y genisoimage` which is needed for the Packer vSphere Plugin to create VMs
-  Clone repo to `/srv/`

https://developer.hashicorp.com/packer/install#linux

https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu

## Create auto.pkrvars.hcl
-   change directory `cd` to `/srv/vdi-master-automation/packer`
-   use `auto.pkrvars.hcl.sample` to create `auto.pkrvars.hcl` with all needed variables
    -   Windows ISO and VMware Tools files are needed on the datastore

## Run
-   change directory `cd` to `/srv/vdi-master-automation/packer` and run
    -   `packer init .` to install Packer plugins from main.pkr.hcl
-   `packer validate -var-file='auto.pkrvars.hcl' .` to validate main.pkr.hcl in combination with the needed variables
-   `packer build -var-file='auto.pkrvars.hcl' .` to start the VM build process