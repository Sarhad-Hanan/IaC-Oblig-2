# OperaTerra E-commerce Platform Infrastructure Deployment
## Introduction
OperaTerra is launching a new e-commerce platform that requires a robust and scalable infrastructure on Microsoft Azure.
As part of the DevOps team, I have set up the necessary infrastructure using Terraform and automated the deployment process
with a CI/CD pipeline powered by GitHub Actions.

## Project Overview
### The infrastructure includes the following components:

- Virtual Network (VNet) with subnets for isolating resources.
- Azure Service Plan for hosting the web application.
- SQL Database for storing product and user data.
- Azure Blob Storage for storing product images.
- Load Balancer to distribute traffic to the web application.
- key vault for storing sensitive information like database credentials and storage account keys.

### Project structure
The project is organized into the following directories:
```
├── backend-setup/
│   ├── main.tf
│   ├── variables.tf
│   ├── backend.tfvars
│   ├── outputs.tf
├── global/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── global.tfvars
├── deployments/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── dev.tfvars
│   ├── staging.tfvars
│   ├── prod.tfvars
│   ├── backend.dev.conf
│   ├── backend.staging.conf
│   ├── backend.prod.conf
├── modules/
│   ├── network/
│   ├── storage_account/
│   ├── key_vault/
│   ├── app_service_plan/
│   ├── sql_database/
│   ├── load_balancer/
├── .github/
│   └── workflows/
│       ├── deployments.yml
│       ├── pull_request.yml
│       ├── destroy.yml
├── README.md
|── gitignore
|
──
```
### I have implemented this infrastructure across three environments:

- Development (dev)
- Staging
- Production (prod)

## Infrastructure Implementation Details
### Modular Approach
#### To ensure reusability and maintainability, I have created Terraform modules for each of the main components:

- Networking Module: Sets up the Virtual Network and subnets.
- App Service Module: Manages the Azure Service Plan.
- Database Module: Handles the SQL Database creation.
- Storage Module: Manages the Blob Storage account.
- Load Balancer Module: Configures the Load Balancer.
- key vault Module: Configures the Key Vault and manages secrets (storage account key, database login and password).

### Environment Customization
I have used locals in Terraform to customize configurations based on the environment (dev, staging, prod). 
This allows us to adjust resource settings like SKU sizes or replication settings without duplicating code.

### Unique Resource Naming
To prevent naming conflicts and ensure that resources are unique across environments, I have implemented random name generation.
This appends a random suffix to resource names, making them globally unique.

### Remote State Management
I am using an Azure Storage Account to store Terraform state files remotely. This ensures that the state is shared among team members and remains consistent.

## CI/CD Pipeline with GitHub Actions
### Branching Strategy
#### I have adopted a branching strategy that aligns with my environments:

- Feature Branches: Used for developing new features or changes.
- Environment Branches: dev, staging, and prod branches correspond to their respective environments.

### Code Reviews and Quality Assurance
#### Before merging changes into the environment branches, all code undergoes a series of automated checks:

- Terraform Format Check: Ensures code is properly formatted.
- Terraform Validate: Checks the syntax and configuration of the Terraform files.
- Terraform Linting: Uses tools like tflint and tfsec(Trivy) to identify potential issues or security vulnerabilities.
  These checks are triggered via Pull Requests, enforcing code reviews and quality assurance before changes are deployed.
### Automated Deployments
Merging changes into the dev or staging branches automatically triggers a workflow that plans and applies the
infrastructure changes to the respective environment.

### Production Deployment Approval
Deployments to the prod branch require manual approval from at least one authorized person.
This adds an extra layer of security, ensuring that critical changes are reviewed before affecting the production environment.

## How to Run the Project
### Prerequisites
- Azure Subscription: You need an active Azure subscription.
- Azure CLI: Installed and authenticated.
- Terraform: Installed on your local machine.
- GitHub Account: Access to the repository

### Setting Up the Backend
1. Navigate to the Backend Setup Directory:
    ```
    cd backend-setup
    ```
2. Initialize the Backend:
    ```
    terraform init
    ```
3. Apply the Backend Configuration:
    ```
   terraform apply -var-file="backend.tfvars"
    ```
4. When prompted, enter the subscription ID for your Azure account(if not added to the backend.tfvars file).

### Deploying Global Resources
1. Navigate to the Global Directory:
    ```
    cd global
    ```
   or if you are in the backend-setup directory:
    ```
    cd ../global
    ```
2. Initialize the Terraform Configuration:
    ```
    terraform init
    ```
   (add -reconfigure if you have already initialized the configuration)
3. Apply the Deployment:
    ```
    terraform apply -var-file="global.tfvars"
    ```
4. When prompted, enter the subscription ID for your Azure account(if not added to the global.tfvars file).

### Deploying Environment-Specific Resources
1. Navigate to the Deployments Directory:
    ```
    cd deployments
    ```
   or if you are in the global directory:
    ```
    cd ../deployments
    ```
2. Initialize the Terraform Configuration for thr different environments:
- Please add the subscription ID to the respective "environment".tfvars file. Or you will be prompted to enter it during the plan/apply command.
#### Development Environment
1. Initialize the Terraform Configuration:
    ```
    terraform init -backend-config="backend.dev.conf"
    ``` 
2. Plan the Deployment:
    ```
    terraform plan -var-file="dev.tfvars"
    ```
3. Apply the Deployment:
    ```
    terraform apply -var-file="dev.tfvars"
    ```
#### Staging Environment
1. Initialize the Terraform Configuration:
    ```
    terraform init -backend-config="backend.staging.conf"
    ```
2. Plan the Deployment:
    ```
    terraform plan -var-file="staging.tfvars"
    ```
3. Apply the Deployment:
    ```
    terraform apply -var-file="staging.tfvars"
    ```
#### Production Environment
1. Initialize the Terraform Configuration:
    ```
    terraform init -backend-config="backend.prod.conf"
    ```
2. Plan the Deployment:
    ```
    terraform plan -var-file="prod.tfvars"
    ```
3. Apply the Deployment:
    ```
    terraform apply -var-file="prod.tfvars"
    ```
### CI/CD Pipeline
- Everything is automated with GitHub Actions. Simply push your changes to the respective branches.
- The CI/CD pipeline will run the necessary checks and deploy the changes to the appropriate environment.
- There is a manual approval step for the production environment. Once approved, the changes will be deployed.
##### Approving Production Deployments
1. Navigate to the Actions Tab: In your GitHub repository.
2. Find the Pending Workflow: Look for the workflow awaiting approval.
3. Approve the Deployment: Follow the prompts to approve and proceed with the deployment.

- There is a destroy workflow for manual destruction of the resources in the respective environments. This triggers only 
manually by the user, please head to the workflow section in the GitHub repository and choose the destroy workflow and then choose 
the environment you want to destroy.
#### Automated Checks
When you open a pull request, the following checks will run automatically:

- Terraform Format Check
- Terraform Validate
- Terraform Linting
- Security Scan

Ensure all checks pass before requesting a review.

## Conclusion
This project successfully sets up the required infrastructure for OperaTerra's new e-commerce platform across multiple environments.
By leveraging Terraform modules, environment-specific configurations, and a CI/CD pipeline with GitHub Actions, 
I ensure a consistent and secure deployment process.

## Author
- Yasin Hessnawi

## Contributions

- GitHub copilot (both in the code and online at the GitHub website)

## contact
```
 yasinmh@stud.ntnu.no
```

