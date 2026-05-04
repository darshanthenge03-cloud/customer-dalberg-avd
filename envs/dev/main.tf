provider "azurerm" {
  features {}
}

module "network" {
  source = "git::https://github.com/darshanthenge03-cloud/terraform-azure-modules.git//network"

  resource_group_name = "rg-network-dev"
  location            = "Central India"

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

module "avd" {
  source = "git::https://github.com/darshanthenge03-cloud/terraform-azure-modules.git//avd"

  subnet_id = module.network.private_subnet_ids["app-subnet"]

  host_pool_name      = "avd-hp-dev"
  app_group_name      = "avd-dag-dev"
  workspace_name      = "avd-ws-dev"
  resource_group_name = "rg-avd-dev"
  location            = "Central India"

  session_host_count = 1
  admin_username     = var.admin_username
  admin_password     = var.admin_password
}
