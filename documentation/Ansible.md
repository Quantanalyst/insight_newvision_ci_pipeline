# How I used Ansible in this project

What is Ansible?
 - It is an open source tool to automates application deployment, intra service orchestration, and most importantly configuration management. 
 - It is acquired by Red Hat in 2015.
 - It is a push-based architecture
 - It uses a YAML file called playbook to define automation tasks in order
 - Ansible Playbooks are the building blocks for all the use cases of Ansible.
 - All the controlling happens in a machine called Ansible controller and will be pushed to remote target machines. 
 - Ansible uses SSH, with no agents to install on remote systems.


Notes about Ansible:
 - You can bundle a group of hosts and control them as a group
 - You run your playbooks from your local computer
 - You give ip addresses of the resources to Ansible and it pushes configuration to those resources.
 - It is built with Python, so you need Python on your hosts for Ansible to work. 
 - It uses SSH to connect to remote hosts.
 - Ansible uses Jinja2 templating to enable dynamic expressions and access to variables. 


How to install Ansible?
 - step 1: ```sudo apt-get update```
 - step 2: ```sudo apt-get install software-properties-common -y```
 - step 3: add Ansible repository to your repos ```sudo apt-add-repository ppa:ansible/ansible```, click ```ENTER``` when prompted
 - step 4: update your repos again ```sudo apt-get update```
 - step 5: install Ansible ```sudo apt-get install ansible -y```


Where is host inventory?
 - default path: ```/etc/ansible/hosts```

What is ansible module?
 - A module is a reusable, standalone script that Ansible runs on your behalf, either locally or remotely. Modules (also referred to as “task plugins” or “library plugins”) are discrete units of code that can be used from the command line or in a playbook task. Modules can be used to perform specific tasks like changing a database password or spinning up a cloud instance.
 - examples: ```$ ansible all -m ping```
 - example: ```$ ansible webservers -m command -a "ls"

How to get started with Ansible?
 1. add the ip of the remote target node to the list of hosts
  - ```$ sudo nano /etc/ansible/hosts``` -> add a group, e.g. [test-servers] -> under the group, add the handle@ip address, e.g. ```ubuntu@50.112.51.89```
 2. give the remote computer your ssh keys using ```$ ssh-copy-id -i ubuntu@50.112.51.89```
 3. ping your remote computer to make sure it is connected using ```ansible -m ping test-servers```
 4. play your ansible playbook using ```ansible-playbook <playbook_name>```



 




















### Reference:

- Building Repeatable Infrastructure with Terraform and Ansible on AWS [link](https://medium.com/faun/building-repeatable-infrastructure-with-terraform-and-ansible-on-aws-3f082cd398ad)
