# tool-infrastructure

This project is used to maintain the codes to operate the infrastructure on the Azure.

- Download the Project
```sh
git clone https://github.com/jingzichen/tool-infrastructure.git
```

# Prerequisite
## I. Setup Azure Provider
Authenticating using a Service Principal with a Client Certificate.
[[guide]](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_certificate.html)

Note, this authorization settings needs **Subscription Owner** to create.

### Generating a Client Certificate
```sh
$ openssl req -newkey rsa:4096 -nodes -keyout "service-principal.key" -out "service-principal.csr"

$ openssl x509 -signkey "service-principal.key" -in "service-principal.csr" -req -days 730 -out "service-principal.crt"

$ openssl pkcs12 -export -out "service-principal.pfx" -inkey "service-principal.key" -in "service-principal.crt"
# Remember the input password, it will be configured as `client_certificate_password` while setting azurerm provider in Terraform.
```

### Creating the Service Principal
1. Go to Azure Portal
2. Navigate to the **Azure Active Directory**
3. Select **Manage** > **App registrations**

### Assigning the Client Certificate to the Service Principal
1. Go to **Manage** > **App registrations**
2. Select the Service Principal created from above
3. Go to **Certificates & secrets** > **Certificates**
   1. Click **Upload certificate** to upload the `service-principal.crt` and then hitting **Save**
### Allowing the Service Principal to manage the Subscription
1. Navigate to the Subscription
2. Click **Access Control (IAM)** and finally **Add role assignment**
3. Assign `Contributor` to the target Service Principal

### Configuring the Service Principal in Terraform
1. Navigate to the **Azure Active Directory**
2. Select **Manage** > **App registrations**
3. Select the target Service Principal
4. Retrieve the following information from **Overview** blade
   - Application ID: `client_id`
   - Directory ID: `tenant_id`
5. Configure
   ```sh
   provider "azurerm" {
       subscription_id             = "${var.subscription_id}"
       client_id                   = "${var.client_id}"
       client_certificate_path     = "${var.client_certificate_path}"
       client_certificate_password = "${var.client_certificate_password}"
       tenant_id                   = "${var.tenant_id}"
   }
   ```

## II. Set up pipeline to deploy azure infra using Terraform

### Store Terraform state in Azure Storage

1. Before you use Azure Storage as a back end, you must create a storage account.<br>
- Configure Terraform state back end
```
terraform {
   backend "azurerm" {
      resource_group_name   = <###Please enter resource group name###>
      storage_account_name  = <###Please enter the name of the Azure Storage account###>
      container_name        = <###Please enter the name of the blob container###>
      key                   = "terraform.tfstate"
#     access_key            = <###Use an environment variable for the access_key value###>
	}
}
```

Ref.:https://www.terraform.io/docs/backends/types/azurerm.html

### Configure state back end

```tf
terraform {
   backend "azurerm" {
      resource_group_name   = <###Please enter resource group name###>
      storage_account_name  = <###Please enter the name of the Azure Storage account###>
      container_name        = <###Please enter the name of the blob container###>
      key                   = "terraform.tfstate"
#     access_key            = <###Use an environment variable for the access_key value###>
	}
}
```
#### terraform command

```sh
## load storageaccount tfstatus
$ terraform init -backend-config="access_key=$BACKEND_ACCESS_KEY"
## verify script
$ terraform validate
## show terraform dry-run result
$ terraform plan -var-file=./bootstrap.tfvars -out=PLAN
$ terraform show PLAN
$ terraform apply -input=false PLAN
```
### Terraform pipeline
Use Gitlab CI pipeline to deploy azure infrastructure with Terraform.

## example
![architecture](/readme/architecture.png)