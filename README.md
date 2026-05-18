<div align="center">

# ☁️ Dalberg Azure Virtual Desktop Platform

### Automated Azure Virtual Desktop deployment using Terraform and GitHub Actions

Modern infrastructure deployment for Azure Virtual Desktop environments using reusable Terraform modules and CI/CD automation.

<br>

<p align="center">
  <img src="https://img.shields.io/badge/Azure-0078D4?style=flat-square&logo=microsoftazure&logoColor=white"/>
  <img src="https://img.shields.io/badge/Terraform-623CE4?style=flat-square&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white"/>
  <img src="https://img.shields.io/badge/Azure_Virtual_Desktop-0A66C2?style=flat-square"/>
</p>

<br>

<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:0078D4,100:7C4DFF&height=130&section=header&text=Azure%20Virtual%20Desktop&fontSize=34&fontColor=ffffff&animation=fadeIn"/>

</div>

---

<div align="center">

[Overview](#-overview) •
[Architecture](#-enterprise-architecture) •
[Networking](#-network-architecture) •
[CI/CD](#-cicd-workflow) •
[Deployment](#-deployment-steps) •
[Security](#-security-recommendations)

</div>

<br>

<div align="center">

| Environment | IaC | CI/CD | Platform |
|---|---|---|---|
| Development | Terraform | GitHub Actions | Azure Virtual Desktop |

</div>

---

# <img width="28" src="https://img.icons8.com/fluency/48/document.png"/> Overview

This repository contains the customer deployment configuration for the Dalberg Azure Virtual Desktop environment.

The deployment is built using:

- Terraform Infrastructure as Code
- GitHub Actions CI/CD automation
- Azure remote backend state management
- Reusable Terraform modules
- Dedicated network segmentation for AVD workloads
- Automated Active Directory domain join
- Automated Azure Virtual Desktop host registration

> [!NOTE]
> This repository contains only customer deployment logic and environment-specific configuration.  
> Shared Terraform modules are maintained separately.

---

# <img width="28" src="https://img.icons8.com/fluency/48/goal.png"/> Platform Objectives

- Standardized Azure Virtual Desktop deployment
- Reusable infrastructure deployment model
- Consistent naming conventions
- Simplified CI/CD automation
- Scalable network architecture
- Future-ready platform design
- Automated Active Directory domain join
- Automated AVD session host onboarding

---

# <img width="28" src="https://img.icons8.com/fluency/48/system-task.png"/> Enterprise Architecture

## High-Level Architecture

```text
┌──────────────────────────────────────────────────┐
│               Azure Subscription                 │
└──────────────────────────────────────────────────┘
                           │
            ┌──────────────┴──────────────┐
            │                             │
            ▼                             ▼

┌─────────────────────────┐   ┌─────────────────────────┐
│      Networking RG      │   │         AVD RG          │
├─────────────────────────┤   ├─────────────────────────┤
│ • Virtual Network       │   │ • Host Pool             │
│ • AVD Subnet            │   │ • Workspace             │
│ • ADDS Subnet           │   │ • Desktop App Group     │
│ • Bastion Subnet        │   │ • Session Hosts         │
│ • GatewaySubnet         │   │ • AVD Registration      │
└─────────────────────────┘   └─────────────────────────┘

                           │
                           ▼

┌──────────────────────────────────────────────────┐
│               Terraform Backend                  │
├──────────────────────────────────────────────────┤
│ • Azure Storage Account                          │
│ • Remote Terraform State                         │
└──────────────────────────────────────────────────┘
```

<div align="center">

Built using reusable Terraform modules and GitHub Actions workflows.

</div>

---

# <img width="28" src="https://img.icons8.com/fluency/48/opened-folder.png"/> Repository Structure

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

# <img width="28" src="https://img.icons8.com/fluency/48/settings.png"/> Deployment Architecture

This repository is responsible for:

- Customer deployment configuration
- Environment-specific variables
- Terraform backend configuration
- GitHub Actions deployment workflows
- Reusable module consumption
- Automated AD domain join configuration
- Automated session host onboarding

Reusable infrastructure modules are maintained separately in:

```text
terraform-azure-modules
```

---

# <img width="28" src="https://img.icons8.com/fluency/48/networking-manager.png"/> Network Architecture

## Virtual Network

Dedicated Azure Virtual Network for Azure Virtual Desktop resources.

### Example

```text
dalberg-dev-cin-vnet
```

### Address Space

```text
10.0.0.0/16
```

---

## Subnet Design

| Subnet | Purpose |
|---|---|
| `snet-avd` | Azure Virtual Desktop Session Hosts |
| `snet-ad` | Active Directory Domain Services |
| `snet-bastion` | Azure Bastion |
| `GatewaySubnet` | VPN Gateway |

> [!NOTE]
> Separate subnets are maintained for workload isolation, simplified NSG management, and future ADDS / FSLogix integration.

---

# <img width="28" src="https://img.icons8.com/fluency/48/domain.png"/> Automated Domain Join

Session hosts are automatically joined to the Active Directory Domain Services (ADDS) domain during deployment.

The domain join process is fully automated using Terraform deployment extensions and infrastructure automation.

## Automated Configuration

| Component | Purpose |
|---|---|
| ADDS Integration | Automatic domain join |
| VM Extensions | Domain join execution |
| OU Placement | Centralized management |
| DNS Configuration | ADDS name resolution |
| Session Host Registration | Automatic AVD onboarding |

---

## Domain Join Workflow

```text
Terraform Deployment
        ↓
Session Host Provisioning
        ↓
DNS Configuration
        ↓
AD Domain Join Extension
        ↓
Automatic Reboot
        ↓
AVD Agent Registration
        ↓
Host Pool Availability
```

---

## Example Domain Configuration

```text
Domain Name: dalberg.local
OU Path: OU=AVD,DC=dalberg,DC=local
```

> [!NOTE]
> Session hosts automatically rejoin the domain during redeployment or scaling activities through deployment automation.

---

# <img width="28" src="https://img.icons8.com/fluency/48/monitor.png"/> Azure Virtual Desktop Components

## Host Pool

| Setting | Value |
|---|---|
| Type | Pooled |
| Load Balancer | DepthFirst |

### Example

```text
dalberg-dev-cin-avd-hp
```

---

## Workspace

```text
dalberg-dev-cin-avd-ws
```

---

## Desktop Application Group

```text
dalberg-dev-cin-avd-dag
```

---

# <img width="28" src="https://img.icons8.com/fluency/48/laptop.png"/> Session Hosts

Windows 11 multi-session virtual machines are deployed as Azure Virtual Desktop session hosts with automated Active Directory domain join and host pool registration.

| Component | Configuration |
|---|---|
| Operating System | Windows 11 Enterprise Multi-Session |
| VM Size | Standard_D4s_v5 |
| Disk Type | Standard SSD |
| Session Host Count | Configurable |
| Domain Join | Automated |
| AVD Registration | Automated |

### Example

```text
dalberg-dev-cin-avd-vm-01
```

---

# <img width="28" src="https://img.icons8.com/fluency/48/price-tag.png"/> Naming Convention

```text
<client>-<environment>-<region>-<service>-<resource>
```

## Examples

| Resource | Example |
|---|---|
| Resource Group | dalberg-dev-cin-rg-avd |
| Virtual Network | dalberg-dev-cin-vnet |
| Host Pool | dalberg-dev-cin-avd-hp |
| Workspace | dalberg-dev-cin-avd-ws |
| Virtual Machine | dalberg-dev-cin-avd-vm-01 |

---

# <img width="28" src="https://img.icons8.com/fluency/48/database.png"/> Terraform Backend

Terraform state is stored remotely in Azure Storage Account.

| Component | Configuration |
|---|---|
| Resource Group | rg-dalberg-terraform-state |
| Storage Account | tfstatedalbergdevstr |
| Container | tfstate |

---

# <img width="28" src="https://img.icons8.com/fluency/48/process.png"/> CI/CD Workflow

GitHub Actions is used for infrastructure deployment automation.

### Workflow Location

```text
.github/workflows/terraform.yml
```

### Deployment Pipeline

```text
Repository Checkout
        ↓
Terraform Installation
        ↓
Azure Authentication
        ↓
Terraform Init
        ↓
Terraform Validate
        ↓
Terraform Plan
        ↓
Terraform Apply
        ↓
AD Domain Join Automation
        ↓
AVD Host Pool Registration
```

---

# <img width="28" src="https://img.icons8.com/fluency/48/key-security.png"/> GitHub Secrets

| Secret | Purpose |
|---|---|
| AZURE_CREDENTIALS | Azure Service Principal Authentication |
| TF_VAR_admin_username | Session Host Administrator Username |
| TF_VAR_admin_password | Session Host Administrator Password |
| TF_VAR_domain_username | AD Domain Join Account |
| TF_VAR_domain_password | AD Domain Join Password |

---

# <img width="28" src="https://img.icons8.com/fluency/48/rocket.png"/> Deployment Steps

## Clone Repository

```bash
git clone <repository-url>
cd customer-dalberg-avd
```

## Configure GitHub Secrets

Configure all required repository secrets before deployment.

---

## Push Changes

```bash
git add .
git commit -m "Deploy Dalberg AVD infrastructure"
git push
```

---

## Monitor Deployment

```text
GitHub
→ Actions
→ Terraform Deploy
```

---

## Validate Resources

```text
Azure Portal
→ Azure Virtual Desktop
→ Host Pools
→ Session Hosts
```

Expected session host state:

```text
Available
```

---

# <img width="28" src="https://img.icons8.com/fluency/48/maintenance.png"/> Common Issues

## VM Name Length Limitation

Windows computer names are limited to 15 characters.

> [!NOTE]
> Use separate `computer_name` values when required for session hosts.

---

## GatewaySubnet NSG Restriction

Azure does not allow NSG association to `GatewaySubnet`.

> [!NOTE]
> Exclude `GatewaySubnet` from NSG association logic.

---

## Terraform State Conflicts

Occurs when infrastructure resources already exist outside Terraform state.

Recommended approach:

- Use remote backend state
- Avoid manual resource creation
- Import existing resources when required

---

# <img width="28" src="https://img.icons8.com/fluency/48/lock.png"/> Security Recommendations

- Store credentials in GitHub Secrets
- Avoid committing secrets to Git
- Use remote backend state
- Apply subnet segmentation
- Follow least privilege access
- Use workload-specific NSGs

---

# <img width="28" src="https://img.icons8.com/fluency/48/toolbox.png"/> Technologies Used

| Technology | Purpose |
|---|---|
| Microsoft Azure | Cloud Platform |
| Terraform | Infrastructure as Code |
| GitHub Actions | CI/CD Automation |
| Azure Virtual Desktop | Desktop Virtualization |
| Active Directory Domain Services | Identity Management |
| Azure Networking | Network Architecture |
| Azure Storage Account | Remote Terraform Backend |

---

# <img width="28" src="https://img.icons8.com/fluency/48/administrator-male.png"/> Author

**Darshan Thenge**  
Cloud Engineer focused on Azure, Terraform, DevOps, and Infrastructure Automation.

GitHub:  
https://github.com/darshanthenge03-cloud
<br>
### Core Stack
<p align="left">
  <img width="42" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/azure/azure-original.svg" />
  <img width="42" src="https://skillicons.dev/icons?i=aws" />
  <img width="42" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/terraform/terraform-original.svg" />
  <img width="42" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" />
  <img width="42" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/gitlab/gitlab-original.svg" />
  <img width="42" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/azuredevops/azuredevops-original.svg" />
  <img width="42" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/powershell/powershell-original.svg" />
  <img width="42" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg" />
</p>
<div align="center">
<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:0078D4,100:7C4DFF&height=70&section=footer"/>
</div>
