# Delyvery applications
Delivers the application files to the virtual machine.

```
- name: Delivery application
  copy:
    src: "{{ source_directory }}"
    dest: "{{ project_directory }}"
```

### Role structure:

In this case, the role structure includes only `tasks/` and `vars/`.
