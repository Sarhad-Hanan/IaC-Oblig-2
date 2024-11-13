# This file holds values for the variables used in the backend setup configuration.
# It provides the specific configurations needed to deploy resources in Azure.

# The Azure subscription ID for deploying resources.
subscription_id = "70438f0b-03a6-455f-a559-dd257af223a9"

# The name of the resource group where the backend state resources will be managed.
rgname = "rg-sarhad-backend-state"

# The Azure region where the resource group and storage account will be deployed.
location = "westeurope"

# The name of the storage account used for storing the Terraform state. Must be globally unique.
backend_storage_name = "sarhadbackendstorage"

# The name of the storage container within the storage account for storing the Terraform state file.
storage_container_name = "tfstate"
