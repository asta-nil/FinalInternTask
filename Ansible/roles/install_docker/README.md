## Install Docker

This role installs the docker using the repository.

### Role structure:

In this case, the role structure includes only `tasks/`.

### The procedure:
 1. Update Ubuntu cache
 ```
 - name: Update Ubuntu cache
  apt:
    update_cache: true
    force_apt_get: true
    cache_valid_time: 3600
 ```
 2. Install required system packages
 ```
 - name: Install required system packages   
  apt:
    pkg:   
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common
      - python3-pip
      - virtualenv
      - python3-setuptools
    state: latest
    update_cache: true
 ```
 3. Add Docker GPG apt Key
 ```
 - name: Add Docker GPG apt Key
  apt_key:
    url: https://download.docker.com/linux/ubuntu/gpg
    state: present
 ```
 4.Add Docker Repository
 ```
 - name: Add Docker Repository
  apt_repository:
    repo: deb https://download.docker.com/linux/ubuntu focal stable
    state: present
 ```
 5. Update apt and install docker-ce
 ```
 - name: Update apt and install docker-ce
  apt:
    name: docker-ce
    state: latest
    update_cache: true
 ```
 6. Install Docker Module for Python
```
- name: Install Docker Module for Python
  pip:
    name: docker
```
