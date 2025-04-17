terraform {
    required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
  backend "azurerm" {
    resource_group_name = "value"
    storage_account_name = "value"
    container_name = "value"
    key    = ""
  }

}

provider "azurerm" {
  features {}
}

module "azure_web_app"{
    source = "../../modules/azure-webapp"
    environment = var.environment
    region = var.environment
}