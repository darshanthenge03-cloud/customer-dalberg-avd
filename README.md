# 🚀 Customer Dalberg Azure Virtual Desktop Platform

<div align="center">

# ☁️ Enterprise Azure Virtual Desktop Deployment

### Automated Azure Virtual Desktop Infrastructure using Terraform, GitHub Actions & Azure Cloud

<br>

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/Azure-Cloud-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?style=for-the-badge&logo=githubactions&logoColor=white" />
  <img src="https://img.shields.io/badge/AVD-Enterprise_Platform-0A66C2?style=for-the-badge" />
</p>

<br>

<p align="center">
Enterprise-grade Azure Virtual Desktop deployment architecture built using reusable Terraform modules and GitHub Actions automation.
</p>

<p align="center">
<b>Built and maintained by Darshan Thenge</b>
</p>

</div>

---

# 📖 Overview

This repository contains the customer-specific deployment configuration for the Dalberg Azure Virtual Desktop (AVD) environment.

The infrastructure is deployed using:

* Terraform Infrastructure as Code (IaC)
* Reusable enterprise Terraform modules
* GitHub Actions CI/CD automation
* Azure remote backend state management

This repository is responsible for:

* Customer-specific deployment configuration
* Environment-specific variables
* CI/CD workflow execution
* Terraform backend configuration
* Calling reusable Terraform modules

Reusable modules are maintained separately in:

```text
terraform-azure-modules
```

This architecture follows enterprise platform engineering practices where:

* Shared infrastructure modules remain centralized
* Customer deployments remain isolated
* Infrastructure becomes reusable and scalable
* CI/CD remains standardized
* Naming conventions stay consistent

---

# 🏗️ Solution Architecture

## High-Level Architecture

```text
Azure Subscription
│
├── Resource Group: Network
│   ├── Virtual Network
│   ├── AVD Subnet
│   ├── ADDS Subnet
│   ├── Bastion Subnet
│   └── GatewaySubnet
│
├── Resource Group: AVD
│   ├── Azure Virtual Desktop Host Pool
│   ├── Workspace
│   ├── Desktop Application Group
│   ├── Session Host Virtual Machines
│   └── Network Interfaces
│
└── Terraform Backend
    └── Azure Storage Account
```

---

# 📁 Repository Structure

```text
customer-dalberg-avd/
│
├── envs/
│   └── dev/
│       ├── main.tf
│       └── variables.tf
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
└── README.md
```

---

# ⚙️ Deployment Model

This repository only contains customer deployment logic.

All reusable infrastructure components are consumed from:

```text
terraform-azure-modules
```

This separation provides:

* Better scalability
* Cleaner architecture
* Easier multi-customer onboarding
* Centralized module management
* Better CI/CD maintainability

---

# 🌐 Network Architecture

## Virtual Network

A dedicated Azure Virtual Network is deployed for the AVD environment.

### Example

```text
dalberg-dev-cin-vnet
```

### Address Space

```text
10.0.0.0/16
```

---

# 🧩 Subnet Design

Separate subnets are used for workload segmentation and future scalability.

| Subnet        | Purpose                             |
| ------------- | ----------------------------------- |
| snet-avd      | Azure Virtual Desktop Session Hosts |
| snet-ad       | Active Directory Domain Services    |
| snet-bastion  | Azure Bastion                       |
| GatewaySubnet | VPN Gateway                         |

---

# 🔐 Why Separate Subnets?

Subnet segmentation provides:

* Better security isolation
* Easier NSG management
* Cleaner workload separation
* Better scalability
* Easier troubleshooting
* Future FSLogix integration support
* Future ADDS integration support

---

# 🖥️ Azure Virtual Desktop Components

## Host Pool

The Host Pool manages user session distribution across AVD session hosts.

### Example

```text
dalberg-dev-cin-avd-hp
```

### Configuration

| Setting       | Value      |
| ------------- | ---------- |
| Type          | Pooled     |
| Load Balancer | DepthFirst |

---

## Workspace

The Workspace acts as the user access entry point for Azure Virtual Desktop resources.

### Example

```text
dalberg-dev-cin-avd-ws
```

---

## Desktop Application Group

The Desktop Application Group publishes desktop access to users.

### Example

```text
dalberg-dev-cin-avd-dag
```

---

# 💻 Session Host Virtual Machines

Windows 11 multi-session virtual machines are deployed as AVD Session Hosts.

### Example VM Name

```text
dalberg-dev-cin-avd-vm-01
```

---

## VM Configuration

| Setting            | Value                               |
| ------------------ | ----------------------------------- |
| Operating System   | Windows 11 Enterprise Multi-Session |
| VM Size            | Standard_D4s_v5                     |
| Disk Type          | Standard SSD                        |
| Session Host Count | Configurable                        |

---

# 🏷️ Naming Convention

## Standard Naming Format

```text
<client>-<environment>-<region>-<service>-<resource>
```

---

## Naming Examples

| Resource       | Example                   |
| -------------- | ------------------------- |
| Resource Group | dalberg-dev-cin-rg-avd    |
| VNet           | dalberg-dev-cin-vnet      |
| Host Pool      | dalberg-dev-cin-avd-hp    |
| Workspace      | dalberg-dev-cin-avd-ws    |
| VM             | dalberg-dev-cin-avd-vm-01 |

---

# 🌍 Region Naming

| Code | Azure Region  |
| ---- | ------------- |
| cin  | Central India |
| eus  | East US       |
| wus  | West US       |

---

# 🗄️ Terraform Remote Backend

Terraform state is stored remotely in Azure Storage Account.

This provides:

* Remote state management
* State locking
* Team collaboration
* CI/CD compatibility
* Centralized state storage

---

## Backend Configuration

| Component       | Value                      |
| --------------- | -------------------------- |
| Resource Group  | rg-dalberg-terraform-state |
| Storage Account | tfstatedalbergdevstr       |
| Container       | tfstate                    |

---

# ⚙️ CI/CD Pipeline

Infrastructure deployment is fully automated using GitHub Actions.

---

## GitHub Workflow Location

```text
.github/workflows/terraform.yml
```

---

## Deployment Workflow

The pipeline performs:

1. Repository checkout
2. Terraform installation
3. Azure authentication
4. Terraform initialization
5. Terraform validation
6. Terraform planning
7. Terraform deployment

---

# 🔑 GitHub Secrets Required

The following repository secrets must be configured.

| Secret                | Purpose                                   |
| --------------------- | ----------------------------------------- |
| AZURE_CREDENTIALS     | Azure Service Principal authentication    |
| TF_VAR_admin_username | Session Host local administrator username |
| TF_VAR_admin_password | Session Host local administrator password |

---

# 🔒 Azure Permissions Required

The Service Principal used in GitHub Actions requires the following permissions.

| Role                          | Scope                             |
| ----------------------------- | --------------------------------- |
| Contributor                   | Subscription or Resource Group    |
| Storage Blob Data Contributor | Terraform backend storage account |

---

# 🚀 Deployment Steps

## Step 1 — Clone Repository

```bash
git clone <repository-url>
cd customer-dalberg-avd
```

---

## Step 2 — Configure GitHub Secrets

Configure all required GitHub repository secrets.

---

## Step 3 — Push Changes

```bash
git add .
git commit -m "Deploy Dalberg AVD infrastructure"
git push
```

---

## Step 4 — Monitor GitHub Actions

Navigate to:

```text
GitHub
→ Actions
→ Terraform Deploy
```

Verify:

* Terraform Init
* Terraform Plan
* Terraform Apply

complete successfully.

---

## Step 5 — Verify Deployment

Navigate to:

```text
Azure Portal
→ Azure Virtual Desktop
→ Host Pools
→ Session Hosts
```

Expected Result:

```text
Status = Available
```

---

# ✨ Current Features

The current implementation supports:

* Reusable Terraform modules
* Enterprise naming conventions
* Dynamic subnet architecture
* Azure Virtual Desktop deployment
* Session host deployment
* GitHub Actions CI/CD
* Azure remote backend state
* Multi-customer deployment architecture

---

# 🧠 Key Design Decisions

## Separate Module Repository

Infrastructure modules are intentionally maintained in a separate repository to:

* Improve reusability
* Reduce code duplication
* Standardize deployments
* Simplify customer onboarding
* Centralize infrastructure management

---

## Dedicated AVD Subnet

A dedicated subnet is used for AVD Session Hosts to:

* Improve security isolation
* Apply workload-specific NSGs
* Simplify future FSLogix integration
* Improve scalability

---

## Future ADDS Integration

The design includes a dedicated subnet for future:

* Active Directory Domain Services
* DNS integration
* Domain joining
* FSLogix support

---

# 🔮 Future Enhancements

Planned improvements include:

* Active Directory Domain Services deployment
* FSLogix profile containers
* Azure AD Join
* Autoscaling
* Log Analytics integration
* Azure Monitor alerts
* Azure Bastion deployment
* Route tables
* Private endpoints
* NSG rule standardization

---

# 🛠️ Common Issues and Fixes

## VM Name Length Limitation

Windows computer names are limited to 15 characters.

### Solution

Use separate `computer_name` values for Windows hostnames.

---

## GatewaySubnet NSG Restriction

Azure does not allow NSG association to `GatewaySubnet`.

### Solution

Exclude `GatewaySubnet` from NSG association logic.

---

## Terraform State Conflicts

Occurs when resources already exist outside Terraform state.

### Solution

* Use remote backend state
* Avoid manual resource creation
* Import existing resources if required

---

# 🔐 Security Recommendations

* Never commit credentials to Git
* Store secrets in GitHub Secrets
* Use remote backend state
* Use subnet segmentation
* Use NSGs for workload isolation
* Apply least privilege access for Service Principals

---

# 🧰 Technologies Used

* Terraform
* Azure Virtual Desktop
* Azure Networking
* GitHub Actions
* Azure Resource Manager (ARM)
* Azure Storage Account Backend

---

# 👨‍💻 Author

## Darshan Thenge

Cloud Engineer focused on:

* Azure
* AWS
* Terraform
* DevOps
* Azure Virtual Desktop
* Infrastructure Automation

GitHub:

```text
https://github.com/darshanthenge03-cloud
```
