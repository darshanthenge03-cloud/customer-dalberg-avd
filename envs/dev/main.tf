########################################
# Terraform + Backend + Provider
########################################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-dalberg-terraform-state"
    storage_account_name = "tfstatedalbergdevstr"
    container_name       = "tfstate"
    key                  = "avd-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}

########################################
# Create Resource Groups 
########################################

resource "azurerm_resource_group" "network" {
  name     = "rg-network-dev"
  location = "Central India"
}

resource "azurerm_resource_group" "avd" {
  name     = "rg-avd-dev"
  location = "Central India"
}

########################################
# Network Module
########################################

module "network" {
  source = "git::https://github.com/darshanthenge03-cloud/terraform-azure-modules.git//network"

  resource_group_name = azurerm_resource_group.network.name
  location            = azurerm_resource_group.network.location

  vnet_cidr = "10.0.0.0/16"

  public_subnets = {
    "public-1" = "10.0.1.0/24"
  }

  private_subnets = {
    "app-subnet" = "10.0.2.0/24"
  }

  bastion_subnet_cidr = "10.0.3.0/27"
  gateway_subnet_cidr = "10.0.4.0/27"
}

########################################
# AVD Module
########################################

module "avd" {
  source = "git::https://github.com/darshanthenge03-cloud/terraform-azure-modules.git//avd"

  subnet_id = module.network.private_subnet_ids["app-subnet"]

  host_pool_name      = "avd-hp-dev"
  app_group_name      = "avd-dag-dev"
  workspace_name      = "avd-ws-dev"

  resource_group_name = azurerm_resource_group.avd.name
  location            = azurerm_resource_group.avd.location

  session_host_count = 1
  vm_size            = "Standard_D4s_v5"

  admin_username = var.admin_username
  admin_password = var.admin_password
}
