# HadoopAnsible
Ansible scripts for installing hadoop on a master and slaves in one go

prerequesits
* all machines set a static IP
* master has ssh-key and can ssh freely into its slaves

installing ansible on ubuntu

sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible

or as a aone liner:

sudo apt-get update && sudo apt-get install software-properties-common && sudo apt-add-repository ppa:ansible/ansible && sudo apt-get update && sudo apt-get install ansible