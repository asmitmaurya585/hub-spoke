# 🌐 Azure Hub & Spoke Infrastructure with Terraform

[![Terraform](https://img.shields.io/badge/Terraform-1.14.6+-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure Provider](https://img.shields.io/badge/azurerm-v4.81.0-0089D6?logo=microsoftazure&logoColor=white)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
[![Security Scan](https://img.shields.io/badge/Gitleaks-Passed-brightgreen?logo=git&logoColor=white)](https://github.com/zricethezav/gitleaks)
[![Checkov Analysis](https://img.shields.io/badge/Checkov-Validated-blue?logo=bridgecrew&logoColor=white)](https://www.checkov.io/)

A modular, enterprise-grade Infrastructure as Code (IaC) repository built using Terraform to deploy an Azure **Hub and Spoke Virtual Network Architecture** with dynamic subnet provisioning, Network Security Groups (NSGs), Route Tables, and VNet Peerings.

---

## 🏗️ Architecture Overview

The **Hub and Spoke** model provides central isolation, shared network services, and secure multi-environment separation:

```mermaid
graph TD
    subgraph Hub Network ["rg-hub / vnet-hub (10.0.0.0/16)"]
        FW["AzureFirewallSubnet<br/>10.0.1.0/24"]
        BST["AzureBastionSubnet<br/>10.0.2.0/24"]
        GW["GatewaySubnet<br/>10.0.3.0/24"]
        BNSG["nsg-hub-azurebastionsubnet<br/>(Compliant Bastion NSG)"]
        RT_HUB["rt-hub<br/>(Hub Route Table)"]
        BST --- BNSG
    end

    subgraph Dev Spoke ["rg-dev / vnet-spoke-dev (10.1.0.0/16)"]
        DEV_WEB["web<br/>10.1.1.0/24"]
        DEV_APP["app<br/>10.1.2.0/24"]
        RT_DEV["rt-spoke-dev"]
        DEV_WEB --- RT_DEV
        DEV_APP --- RT_DEV
    end

    subgraph Prod Spoke ["rg-prod / vnet-spoke-prod (10.2.0.0/16)"]
        PROD_WEB["web<br/>10.2.1.0/24"]
        PROD_APP["app<br/>10.2.2.0/24"]
        PROD_DB["db<br/>10.2.3.0/24"]
        RT_PROD["rt-spoke-prod"]
        PROD_WEB --- RT_PROD
        PROD_APP --- RT_PROD
        PROD_DB --- RT_PROD
    end

    Hub Network <-->|"Peer (dev)"| Dev Spoke
    Hub Network <-->|"Peer (prod)"| Prod Spoke
```

---

## 📦 Repository Structure

```text
Hub and spoke 12-08-2026/
├── README.md               # Main project documentation
├── .gitignore              # Single root gitignore file
└── hub-spoke-terraform/    # Core Terraform configuration
    ├── main.tf             # Root module orchestration & import blocks
    ├── variables.tf        # Top-level input variable definitions
    ├── terraform.tfvars    # Environment configuration values
    ├── outputs.tf          # Root outputs for VNet & Subnet IDs
    ├── providers.tf        # AzureRM provider configuration
    ├── versions.tf         # Terraform & provider version constraints
    └── modules/
        ├── hub/            # Hub VNet, Bastion NSG, & Route Table module
        ├── spoke/          # Reusable Spoke VNet, NSG, & Route Table module
        ├── peering/        # Bidirectional VNet Peering module
        └── azurerm_resource_group/ # Standalone Resource Group module
```

---

## 🚀 Deployed Resources

### 1. Resource Groups
- `rg-hub` (East US) - Central Hub infrastructure
- `rg-dev` (East US) - Development Spoke workloads
- `rg-prod` (East US) - Production Spoke workloads
- `rg-dev-eastus` & `rg-prod-eastus` - Standalone Resource Groups

### 2. Virtual Networks & Subnets
- **`vnet-hub`** (`10.0.0.0/16`)
  - `AzureFirewallSubnet` (`10.0.1.0/24`)
  - `AzureBastionSubnet` (`10.0.2.0/24`)
  - `GatewaySubnet` (`10.0.3.0/24`)
- **`vnet-spoke-dev`** (`10.1.0.0/16`)
  - `web` (`10.1.1.0/24`), `app` (`10.1.2.0/24`)
- **`vnet-spoke-prod`** (`10.2.0.0/16`)
  - `web` (`10.2.1.0/24`), `app` (`10.2.2.0/24`), `db` (`10.2.3.0/24`)

### 3. Security & Networking Controls
- **Compliant Bastion NSG (`nsg-hub-azurebastionsubnet`)**: Pre-configured with mandatory Inbound rules (`HTTPS`, `GatewayManager`, `AzureLoadBalancer`, `BastionHostCommunication`) and Outbound rules (`SSH/RDP`, `AzureCloud`, `GetSessionInformation`).
- **Spoke NSGs**: Per-subnet isolation for `dev` and `prod` layers.
- **Route Table Exclusions**: Custom Route Tables are excluded from `AzureFirewallSubnet`, `GatewaySubnet`, and `AzureBastionSubnet` to prevent Azure platform policy violations.

---

## 🛠️ Usage Instructions

### Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (v1.14.6+)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) logged in (`az login`)

### Deployment Steps

1. **Navigate to the Terraform code directory:**
   ```bash
   cd "hub-spoke-terraform"
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Validate configuration:**
   ```bash
   terraform validate
   ```

4. **Review execution plan:**
   ```bash
   terraform plan
   ```

5. **Deploy resources to Azure:**
   ```bash
   terraform apply
   ```

---

## 🔐 Security & Scanning

This codebase passes static code analysis and security scans:
- **Gitleaks:** `0` hardcoded secrets or leaks detected.
- **Checkov:** Validated against Azure CIS benchmarks and security standards.

---

## 📝 License
Distributed under the MIT License.