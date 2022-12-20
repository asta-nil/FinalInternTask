# Final_task - Deployment application using GitHub Action.

[![Ansible](https://github.com/netframe-intern-final/Final_task/actions/workflows/ansible.yaml/badge.svg)](https://github.com/netframe-intern-final/Final_task/actions/workflows/ansible.yaml)
[![App](https://github.com/netframe-intern-final/Final_task/actions/workflows/app.yaml/badge.svg)](https://github.com/netframe-intern-final/Final_task/actions/workflows/app.yaml)
[![App](https://github.com/netframe-intern-final/Final_task/actions/workflows/terraform.yaml/badge.svg)](https://github.com/netframe-intern-final/Final_task/actions/workflows/terraform.yaml)

## 1. Documentation for Terraform - [:computer_mouse: CLICK HERE](Terraform/README.md).

## 2. Documentation for Ansible - [:computer_mouse:CLICK HERE](Ansible/README.md).

## 3. Documentation for CI/CD - [:computer_mouse: CLICK HERE](.github/workflows/README.md).


### In a nutshell:

- We have 4 workflows `(main, terraform, app, ansible)`.
- Running the main workflow we starting the whole CI/CD cycle, beginning with deploying infrastructure and ending with the deployment of our application.
- Nonetheless, we can run separately only `app/ansible workflows` if infrastructure already deployed.
- If it necessary to made some changes in the application `(index.php)` and implement them - run wokflow [app.yaml](.github/workflows/app.yaml).
- To check, if everything is done and working properly - type in web browser public IP of VM :computer: and enjoy it. :wink:
 
# FinalInternTask
