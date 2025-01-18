
resource "azurerm_app_configuration" "configStore" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku = "standard"

  tags = local.tags
}


resource "azurerm_app_configuration_key" "configStoreKey" {
  for_each = { for kv in var.keyValues : kv.key => kv }

  configuration_store_id = azurerm_app_configuration.configStore.id
  key                    = each.value.key
  value                  = each.value.value
}

output "appConfigEndpoint" {
  value = azurerm_app_configuration.configStore.endpoint
}

output "appConfigId" {
  value = azurerm_app_configuration.configStore.id
}

output "appConfigName" {
  value = azurerm_app_configuration.configStore.name
}

output "appConfigLocation" {
  value = azurerm_app_configuration.configStore.location
}
