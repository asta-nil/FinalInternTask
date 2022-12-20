# Build application
This role builds and configures the application.  

### Role structure:

In this case, the role structure includes `tasks/ files/ templates/ vars/`.

## Modules
1. Create configuration directory.
```
- name: Create configuration dir
  file:
    path: "{{ project_directory }}/conf"
    state: directory
```
Create a directory to hold the default apache configuration file.
[More information.](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)

2. Copy docker-compose file.
```
- name: Copy docker-compose file
  template:
    src: templates/docker-compose.yaml
    dest: "{{ project_directory }}/docker-compose.yaml"
```
The [docker-compose](templates/README.md) file is intended to build the application directly. The compose file is in the templates folder.
[More information.](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html)

3. Copy apache configuration files.
```
- name: Copy apache configuration files
  copy:
    src: apache2.conf
    dest: "{{ project_directory }}/conf/apache2.conf"
```
This is an apache configuration file which can be used to configure apache. The configuration file is in the files folder.
[More information.](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html)

4. Start docker service.
```
- name: Start docker service
  systemd:
    name: docker
    state: started
    enabled: yes
```
Starting a docker service. Same as running the command `sudo systemctl start docker`
[More information.](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_module.html)

5. Ports setting
```
- name: Ports 80 setting
  ufw:
    state: enabled
    rule: allow
    port: '80'
    proto: tcp

- name: Port setting
  ufw:
    state: enabled
    rule: allow
    port: '22'
    proto: tcp
```
Manage firewall with UFW. Allow all access to tcp ports 80, 22.
[More information.](https://docs.ansible.com/ansible/2.9/modules/ufw_module.html)

6. Build applications
```
- name: Build applications
  docker_compose:
    project_src: "{{ project_directory }}"
    remove_orphans: yes
    pull: "{{ enable_docker_pull }}"
```
Building an application using a previously copied file.
[More information.](https://docs.ansible.com/ansible/2.9/modules/docker_compose_module.html)
