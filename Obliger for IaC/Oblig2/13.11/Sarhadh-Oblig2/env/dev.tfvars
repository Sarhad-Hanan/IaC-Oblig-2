# The deployment environment identifier, used to specify the current environment (e.g., dev, staging, prod)
environment = "dev"

# The Azure subscription ID used for this deployment. This must be updated to match the specific Azure account being targeted.
subscription_id = "70438f0b-03a6-455f-a559-dd257af223a9"

# The name of the Azure resource group that hosts the backend storage for the Terraform remote state.
backend_rgname = "rg-sarhad-backend-state"

# The name of the Azure storage account used for storing the Terraform state file.
backend_saname = "sarhadbackendstorage"

# The Azure region where the resource group and storage account will be deployed.
rgname = "rg-sarhad"