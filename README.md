# Azure Terraform Infrastructure Lab

A hands-on Terraform project demonstrating real-world Azure infrastructure deployment, 
multi-environment management, and infrastructure automation.

## Architecture
```
Azure
├── Resource Group
│   └── Virtual Network (VNet)
│       └── Subnet
│           └── Network Security Group (NSG)
│               ├── Allow SSH (port 22)
│               ├── Allow HTTP (port 80)
│               ├── Allow HTTPS (port 443)
│               └── Deny All Inbound (priority 4096)
```

## Features

- **Remote State** — Terraform state stored in Azure Blob Storage with automatic state locking
- **Multi-Environment** — Separate workspaces for default, dev, and prod environments
- **Environment Variables** — Parameterized infrastructure using tfvars per environment
- **Drift Detection** — Automated bash script checks all environments for configuration drift
- **Safe Deployments** — Deployment script with workspace-aware variable injection and confirmation prompt
- **Lifecycle Protection** — prevent_destroy on critical resources

## Project Structure
```
azure-terraform-practice/
├── main.tf              # Core infrastructure resources
├── variables.tf         # Variable declarations
├── outputs.tf           # Output values
├── terraform.tfvars     # Default environment values
├── dev.tfvars           # Dev environment values
├── prod.tfvars          # Prod environment values
├── tf-deploy.sh         # Safe deployment automation script
├── drift-check.sh       # Multi-workspace drift detection script
└── .gitignore           # Excludes state files and secrets
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription
- GitHub account

## Usage

### Initial Setup
```bash
# Login to Azure
az login

# Initialize Terraform with remote backend
terraform init
```

### Deploy an Environment
```bash
# Switch to desired workspace
terraform workspace select dev

# Deploy using the safe deployment script
. tf-deploy.sh
```

### Check for Drift Across All Environments
```bash
. drift-check.sh
```

### Workspace Management
```bash
terraform workspace list      # list all workspaces
terraform workspace show      # show current workspace
terraform workspace select dev # switch to dev
```

## Environments

| Workspace | VNet CIDR | Subnet CIDR | Environment Tag |
|-----------|-----------|-------------|-----------------|
| default | 10.0.0.0/16 | 10.0.1.0/24 | test |
| dev | 10.0.0.0/16 | 10.0.1.0/24 | dev |
| prod | 10.1.0.0/16 | 10.1.1.0/24 | prod |

## Remote State

State is stored in Azure Blob Storage with workspace isolation:
```
tfstate17441 (Storage Account)
└── tfstate (Container)
      ├── terraform.tfstate          # default workspace
      ├── terraform.tfstateenv:dev   # dev workspace
      └── terraform.tfstateenv:prod  # prod workspace
```

## Security

- State files excluded from version control via `.gitignore`
- tfvars files excluded from version control
- NSG deny-all inbound rule at priority 4096
- Azure RBAC controls state storage access
- State locking prevents concurrent modifications

## Skills Demonstrated

- Terraform IaC on Azure (AzureRM provider)
- Multi-environment workspace management
- Remote state with Azure Blob Storage
- Bash automation scripting
- Infrastructure drift detection
- Azure networking (VNet, Subnet, NSG)
- Azure CLI
- Git version control

## Author

Markus Johnson
[GitHub](https://github.com/marz500000)