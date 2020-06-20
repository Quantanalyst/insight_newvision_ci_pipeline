## Terraform + Ansible

This folder has all the terraform files necessary to provision the project's infrastructure.  

When you initialize terraform with ```terraform init```, it downloads plugins for the providers (e.g. aws) and also the sources defined in the modules. In this project, two modules are defined: one for EC2 instance resource (ubuntu 18.04) and another one for Ansible. Both modules use external codes to provide a template. When you have the template, then you can customize them in your main terraform file. I added two roles to the Ansible module to install Airflow and R on my infrastructure. 

In order to copy necessary files from my local machine to remote hosts, I used ```provisioner``` in terraform and also some modules in the Ansible playbooks. The other available option is to mount a folder locally and put your files inside the folder. If you want to know more about it, check inside the Makefile file. There is a specific command for that purpose.  