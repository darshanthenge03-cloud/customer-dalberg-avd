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
    key                  = "dalberg-dev-avd.tfstate"
  }
}

provider "azurerm" {
  features {}
}

locals {
  client_name   = "dalberg"
  environment   = "dev"
  location      = "Central India"
  location_code = "cin"

  prefix = "${local.client_name}-${local.environment}-${local.location_code}"

  tags = {
    client      = local.client_name
    environment = local.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "network" {
  name     = "${local.prefix}-rg-network"
  location = local.location

  tags = local.tags
}

resource "azurerm_resource_group" "avd" {
  name     = "${local.prefix}-rg-avd"
  location = local.location

  tags = local.tags
}

module "network" {
  source = "git::https://github.com/darshanthenge03-cloud/terraform-azure-modules.git//network"

  resource_group_name = azurerm_resource_group.network.name
  location            = local.location

  vnet_name = "${local.prefix}-vnet"
  vnet_cidr = "10.0.0.0/16"

  subnets = {
    "${local.prefix}-snet-avd"      = "10.0.1.0/24"
    "${local.prefix}-snet-ad"       = "10.0.2.0/24"
    "${local.prefix}-snet-bastion"  = "10.0.3.0/27"
    "GatewaySubnet"                 = "10.0.4.0/27"
  }

  tags = local.tags
}

module "avd" {
  source = "git::https://github.com/darshanthenge03-cloud/terraform-azure-modules.git//avd"

  subnet_id = module.network.subnet_ids["${local.prefix}-snet-avd"]

  host_pool_name = "${local.prefix}-avd-hp"
  app_group_name = "${local.prefix}-avd-dag"
  workspace_name = "${local.prefix}-avd-ws"

  resource_group_name = azurerm_resource_group.avd.name
  location            = local.location

  vm_name_prefix = "${local.prefix}-avd-vm"

  session_host_count = 1
  vm_size            = "Standard_D4s_v5"

  admin_username = var.admin_username
  admin_password = var.admin_password

  tags = local.tags
}
