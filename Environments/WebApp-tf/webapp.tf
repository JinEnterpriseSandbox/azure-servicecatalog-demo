

resource "azurerm_service_plan" "this" {
  name                = "${var.name}-${local.location}-${var.ade_environment_type}-asp"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "this" {
  name                = "${var.name}-${local.location}-${var.ade_environment_type}-webapp"
  resource_group_name = var.resource_group_name
  location            = azurerm_service_plan.this.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {}
}

output "service_plan_id" {
  description = "The ID of the Service Plan"
  value       = azurerm_service_plan.this.id
}

output "web_app_id" {
  description = "The ID of the Windows Web App"
  value       = azurerm_windows_web_app.this.id
}

output "web_app_default_hostname" {
  description = "The default hostname of the Windows Web App"
  value       = azurerm_windows_web_app.this.default_hostname
}