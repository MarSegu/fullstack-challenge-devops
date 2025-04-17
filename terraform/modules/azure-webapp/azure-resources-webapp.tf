resource "azurerm_resource_group" "web_app_rg" {
  name     = "web-app-rg-${var.environment}"
  location = var.region
}