# Ansible playbook
[![Ansible](https://github.com/netframe-intern-final/Final_task/actions/workflows/ansible.yaml/badge.svg)](https://github.com/netframe-intern-final/Final_task/actions/workflows/ansible.yaml)
[![App](https://github.com/netframe-intern-final/Final_task/actions/workflows/app.yaml/badge.svg)](https://github.com/netframe-intern-final/Final_task/actions/workflows/app.yaml)

This playbook is for installing docker, delivering application files and building the application.
This is done by using the ansible roles.
#### File structure:
```
   Ansible
      | - roles
      |     | - build_application
      |     |         | - files
      |     |         |     \ - apache2.conf
      |     |         | - tasks
      |     |         |     \ - main.yml
      |     |         | - templates
      |     |         |     \ - docker-compose.yaml
      |     |         \ - vars
      |     |               \ - main.yml
      |     | - delivery_application
      |     |         | - tasks
      |     |         |     \ - main.yml
      |     |         \ - vars
      |     |               \ - main.yml
      |     \ - install_docker
      |               \ - tasks
      |                     \ - main.yml      
      | - ansible.cfg
      \ - playbook.yml

```

## Roles
1. [Build application](roles/build_application/README.md)
2. [Delivery application](roles/delivery_application/README.md)
3. [Install docker](roles/install_docker/README.md)

## playbook.yml
```
---
- name: Install Docker and Build application
  hosts: variable_host
  become: true
  roles:
    - role: delivery_application
      tags: [delivery]
    - role: install_docker
      tags: [install_docker]
    - role: build_application
      tags: [build]
```
Playbook uses roles with tags in order. Tags have been added to call individual roles (used in the ansible and app workflow).
[More information.](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)


## ansible.cfg
```
[defaults]
host_key_checking	= false
inventory		= inventory
roles_path		= ./Ansible/roles
```
Used to configure ansible. [More information.](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)
