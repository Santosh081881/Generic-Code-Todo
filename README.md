🚀 Azure Infrastructure Provisioning using Terraform

This repository contains fully generic and modular Terraform code to provision Azure infrastructure components using best practices.
The code is designed to be reusable, environment-agnostic, and production-ready.

🧱 Resources Provisioned

The Terraform code provisions the following Azure resources:

Resource Group

Virtual Network (VNet)

Subnets (Application, Database, Bastion)

Network Security Groups (NSG) with flexible rules

Network Interface Cards (NIC)

Virtual Machines (Linux / Windows)

Azure Bastion Host

Azure Key Vault

🏗 Architecture Overview
Resource Group
│
├── Virtual Network
│   ├── App Subnet  ── VM + NIC + NSG
│   ├── DB Subnet   ── VM + NIC + NSG
│   └── Bastion Subnet ── Azure Bastion
│
└── Key Vault

📁 Repository Structure
.
├── modules/
│   ├── resource-group/
│   ├── virtual-network/
│   ├── subnet/
│   ├── nsg/
│   ├── nic/
│   ├── virtual-machine/
│   ├── bastion/
│   └── key-vault/
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── prod/
│
├── provider.tf
├── versions.tf
├── outputs.tf
└── README.md

⚙️ Prerequisites

Azure Subscription

Azure CLI (az) installed

Terraform >= 1.10.x

Azure Service Principal or Managed Identity

Login to Azure:

az login

🔐 Authentication

This setup supports:

Azure CLI authentication

Service Principal authentication

Managed Identity (recommended for pipelines)

📦 Input Variables (Example)
location            = "Central India"
resource_group_name = "rg-dev-demo-001"

vnet_address_space  = ["10.0.0.0/16"]

subnets = {
  app = {
    address_prefix = ["10.0.1.0/24"]
  }
  db = {
    address_prefix = ["10.0.2.0/24"]
  }
  bastion = {
    address_prefix = ["10.0.3.0/27"]
  }
}

vm_size = "Standard_B2s"

🚀 Deployment Steps
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan


To destroy:

terraform destroy

🔄 Environment Support

The code supports multiple environments (dev, test, prod) using:

Separate tfvars

Same reusable modules

Consistent naming conventions

🔐 Security Best Practices Implemented

NSG rules applied at subnet/NIC level

No public IP on VMs

Secure access via Azure Bastion

Secrets stored in Azure Key Vault

Least privilege IAM design

🧠 Design Principles

Modular Terraform structure

Variable-driven configuration

Reusable across environments

Clean outputs for module inter-dependency

Provider & version pinning

📤 Outputs

Resource Group Name

VNet ID

Subnet IDs

VM Private IPs

Key Vault Name

🧪 Tested With

Terraform v1.13.x

AzureRM Provider v3.x

🤝 Contribution

Feel free to fork this repository and raise a PR for improvements.

📌 Notes

Bastion subnet must be named AzureBastionSubnet

Key Vault name must be globally unique

Ensure required Azure permissions before apply

🔄 CI/CD using GitHub Actions (Terraform)

This project supports automated infrastructure deployment using GitHub Actions.
Terraform workflows are triggered on code changes and can deploy infrastructure securely to Azure.

🔐 Authentication with Azure (GitHub Actions)

GitHub Actions uses OIDC-based authentication (recommended) to access Azure securely without storing secrets.

Required Azure Setup:

Azure AD App Registration

Federated Credentials configured for GitHub

Required IAM roles (Contributor / specific RBAC)

👉 No client secrets required.

🔑 Required GitHub Secrets / Variables

Configure the following in GitHub → Settings → Secrets and variables → Actions:

Secrets
AZURE_SUBSCRIPTION_ID
AZURE_TENANT_ID
AZURE_CLIENT_ID

Variables (optional)
TF_VAR_environment=dev

🧾 GitHub Actions Workflow Structure
.github/
└── workflows/
    └── terraform-deploy.yml

🧠 Deployment Flow
GitHub Commit / PR
        ↓
GitHub Actions Trigger
        ↓
OIDC Authentication with Azure
        ↓
Terraform Init → Plan → Apply
        ↓
Azure Infrastructure Provisioned

🔄 Environment-wise Deployment

Supports multi-environment deployment using:

Branch-based strategy (dev, main)

Separate terraform.tfvars

Directory-based environments (/environments/dev, /prod)

Example:

run: terraform apply -var-file=environments/dev/terraform.tfvars

🔐 Security Best Practices (GHA)

OIDC authentication (no secrets leakage)

Least privilege RBAC

No credentials stored in repo

Terraform state stored securely (recommended: Azure Storage backend)

👨‍💻 Author

Santosh Singh
