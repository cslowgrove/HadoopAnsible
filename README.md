# HadoopAnsible
Ansible scripts for installing hadoop on a master and slaves in one go. this script is run from the master node.

prerequesits
* all machines set a static IP
* master has ssh-key and can ssh freely into its slaves

installing ansible on ubuntu

sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible

or as a one liner:

sudo apt-get update && sudo apt-get install software-properties-common && sudo apt-add-repository ppa:ansible/ansible && sudo apt-get update && sudo apt-get install ansible

1. then edit the inventory file to change the IPs and user names for each machine
2. run "./run.sh" to run the scripts
3. reboot master 
