## CI/CD based on Github Actions

### Automatically starting infrastructure via Github Actions
#### There are 4 workflows:
- [Terraform workflow](./terraform.yaml)
- [App delivery workflow](./app.yaml)
- [Ansible provisioning workflow](./ansible.yaml)
- [Main workflow](./main.yaml)

Main worklflow connect all other workflows with:
```ruby
    workflow_call:
``` 

Or they can be called manually because of:
```ruby
    workflow_dispatch:
``` 
#### What's happening after starting main workflow
Main workflow starts with commiting some changes to repository or manualy

All needed environment are in action secrets
1. Firstly, main workflow calls terraform workflow, which create everything that we need on Azure. After this, terraform do an output of variable that next workflows needs to start building:
```ruby
    workflow_call:
    secrets:
      AZURE_CLIENT_ID:
        description: "client id"
        required: true
      AZURE_CLIENT_SECRET:
        description: "client secret"
        required: true
      MVP_SUBSCRIPTION:
        description: "subscription"
        required: true
      AZURE_TENANT_ID:
        description: "tenant id"
        required: true
      PUBLIC_KEY:
        description: "public key"
        required: true
    outputs:
      username:
        description: "Username for vm"
        value: ${{ jobs.terraform_apply.outputs.username }}
      ip_adress:
        description: "Static Ip-adress of vm"
        value: ${{ jobs.terraform_apply.outputs.ip_adress }}

    ...

    - name: Get terraform environment
        id: get_env
        run: |
          cd Terraform
          echo "::set-output name=username::$(terraform output -raw user_name)"
          echo "::set-output name=ip_adress::$(terraform output -raw public_ip)"
``` 
2. Secondly, main workflow calls app delivery workflow, which delivery all needed files to Azure Virtual Machine using Ansible. Ansible needs some outputs from terraform to build inventory as username and ip adress. If we start only this workflow without terraform, ansible takes all variables from actions secrets
3. Thirdly, main workflow calls ansible workflow, which install dependencies and build all our application using [docker compose](../) on virtual machine. Ansible needs some outputs from terraform to build inventory as username and ip adress. If we start only this workflow without terraform, ansible takes all variables from actions secrets:
```ruby
    workflow_call:
    secrets:
      PRIVATE_KEY:
        description: "private key"
        required: true
      IP_ADRESS:
        description: "ip adress"
        required: true
      USERNAME:
        description: "username"
        required: true
    inputs:
      username:
        type: string
        required: true
      ip_adress:
        type: string
        required: true
```
##### All of these workflows can be started without main, that means that all changes can be applied without waiting all other workflows to build

