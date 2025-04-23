resource "azurerm_resource_group" "web_app_rg" {
  name     = "web-app-rg-${var.environment}"
  location = var.region
}

resource "azurerm_storage_account" "static_website" {
  name                     = "ststaticwebapp${var.environment}"
  resource_group_name      = azurerm_resource_group.web_app_rg.name
  location                 = azurerm_resource_group.web_app_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
    error_404_document = "error.html"
  }

  tags = var.tags
}

resource "azurerm_cdn_profile" "example" {
  name                = "cdn-${var.environment}"
  location            = azurerm_resource_group.web_app_rg.location
  resource_group_name = azurerm_resource_group.web_app_rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "example" {
  name                = "cdn-endpoint-${var.environment}"
  profile_name        = azurerm_cdn_profile.example.name
  location            = azurerm_resource_group.web_app_rg.location
  resource_group_name = azurerm_resource_group.web_app_rg.name
  is_http_allowed = true
  is_https_allowed = true
  origin_host_header = azurerm_storage_account.static_website.primary_web_host

  origin {
    name      = "staticwebapp"
    host_name = azurerm_storage_account.static_website.primary_web_host
  }
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "logs-${var.environment}"
  location            = azurerm_resource_group.web_app_rg.location
  resource_group_name = azurerm_resource_group.web_app_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "web-app-diagnostic-setting-${var.environment}"
  target_resource_id = azurerm_storage_account.static_website.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id

  metric {
    category = "Transaction"
    enabled = true
  }

}