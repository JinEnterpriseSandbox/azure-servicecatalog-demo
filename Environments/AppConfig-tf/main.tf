variable "name" {
  description = "Specifies the name of the App Configuration store."
  type        = string
}

variable "location" {
  description = "Specifies the Azure location where the app configuration store should be created."
  type        = string
  default     = "westus3"
}

variable "keyValueNames" {
  description = "Specifies the names of the key-value resources. The name is a combination of key and label with $ as delimiter. The label is optional."
  type        = list(string)
  default     = ["myKey", "myKey$myLabel"]
}

variable "keyValueValues" {
  description = "Specifies the values of the key-value resources. It's optional"
  type        = list(string)
  default     = ["Key-value without label", "Key-value with label"]
}

variable "contentType" {
  description = "Specifies the content type of the key-value resources. For feature flag, the value should be application/vnd.microsoft.appconfig.ff+json;charset=utf-8. For Key Value reference, the value should be application/vnd.microsoft.appconfig.keyvaultref+json;charset=utf-8. Otherwise, it's optional."
  type        = string
  default     = "the-content-type"
}

variable "tags" {
  description = "Adds tags for the key-value resources. It's optional"
  type        = map(string)
  default     = {
    tag1 = "tag-value-1"
    tag2 = "tag-value-2"
  }
}

provider "azurerm" {
  features {}

}

resource "azurerm_app_configuration" "configStore" {
  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  sku = "standard"
}

resource "azurerm_app_configuration_key_value" "configStoreKeyValue" {
  for_each            = toset(var.keyValueNames)
  configuration_store_id = azurerm_app_configuration.configStore.id
  key                 = each.value
  value               = var.keyValueValues[lookup(var.keyValueNames, each.value)]
  content_type        = var.contentType
  tags                = var.tags
}

output "reference_key_value_value" {
  value = azurerm_app_configuration_key_value.configStoreKeyValue[0].value
}
