## Deployment of Azure VM by using Terraform 

### Full deployment of Azure VM using Terraform and GitHub Actions.

#### Resources to be created after deployment:
- Azure Resource Group.
- Azure Virtual Network (1x).
- Azure Subnet (1x).
- Azure NIC (1x).
- Azure NSG, with inbound rules (22 and 80 port opened) and outbound rule.
- Azure Public IP Static (1x).
- Azure Virtual Machine (1x).
- Azure Storage Account with Container (1x).

#### Steps, have to be done before deployment!

1. Terraform directory structure:
```ruby

├── README.md
├── _templates
│   └── inventory.tpl
├── main.tf
├── modules
│   ├── network
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── storage
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vm
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── provider.tf
├── terraform.auto.tfvars
└── variables.tf
```
   - Terraform module consists of root module [root-module](.) and 3 child modules - [vm-module](modules/vm) / [network-module](modules/network) / [storage-module](modules/storage).
   
2. Infrastructure will automatically deploy through GitHub Actions CI workflow - [terraform CI](../.github/workflows/terraform.yaml).

3. Before, have to be created *Service Principal* in Microsoft Azure with appropriate roles.

4. Next, store login data from SP in GitHub Actions-Secrets. Those information will be fetched by Terraform CI workflow:
```ruby
    env:
      ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
      ARM_SUBSCRIPTION_ID: ${{ secrets.MVP_SUBSCRIPTION }}
      ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```
5. *SSH key* need to generate in advance and store *PUBLIC and PRIVATE keys* in GitHub Actions-Secrets as well.

6. Attachment of *SSH key*, described below:
   - Passing the variable in module - vm ([main.tf - module vm](modules/vm/main.tf) & [variables.tf - module vm](modules/vm/variables.tf))
   ```ruby
   admin_ssh_key {
     username           = var.admin_username
     public_key         = var.public_key
   }
   ================================================
   variable "public_key" {
     type 	            = string
     sensitive          = true
   }
   ```
   - Calling secret - *secret.PUBLIC_KEY* and using as inline variable during terraform deployment 
   ```ruby
   run: terraform plan -var "public_key=${{ secrets.PUBLIC_KEY }}" -no-color
   run: terraform apply -var "public_key=${{ secrets.PUBLIC_KEY }}" -no-color -auto-approve
   ```
7. Configure *backend state* in [provider.tf](provider.tf) for storing terraform.tfstate externally:
```ruby
  backend "azurerm" {
    resource_group_name  = "your_values"
    storage_account_name = "your_values"
    container_name       = "your_values"
    key                  = "your_values"
  }
```
8. All values, which are decraled in variables are passing in [terraform.auto.tfvars](terraform.auto.tfvars) and could be changed depends of needs.

9. Once deployed, terraform will generate [inventory file](_templates/inventory.tpl). It can be used by Ansible for provisioning infrastructure. 

10. At the end you will some outputs data like (Public IP, username etc) for future using in CI.


#### Terraform codes and structure performed with aligning to Best Practices :white_check_mark:.


