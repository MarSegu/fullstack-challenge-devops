terraform {
    required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
  backend "azurerm" {
    resource_group_name = "tfstate-rg"
    storage_account_name = "tfstatefullstack"
    container_name = "tfstate"
    key    = "devel/terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  client_id         = var.client_id
  client_secret     = var.client_secret
}

module "azure_web_app"{
  source = "../../modules/azure-webapp"
  environment = var.environment
  region = var.region
  tags = var.tags
}