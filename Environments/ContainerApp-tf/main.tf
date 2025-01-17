variable "containerAppName" {
  description = "Specifies the name of the container app."
  default     = "app-${random_string.container_app_name.result}"
}

variable "containerAppEnvName" {
  description = "Specifies the name of the container app environment."
  default     = "env-${random_string.container_app_env_name.result}"
}

variable "containerAppLogAnalyticsName" {
  description = "Specifies the name of the log analytics workspace."
  default     = "log-${random_string.container_app_log_analytics_name.result}"
}

variable "location" {
  description = "Specifies the location for all resources."
  default     = "westus3"
}

variable "containerImage" {
  description = "Specifies the docker container image to deploy."
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "targetPort" {
  description = "Specifies the container port."
  type        = number
  default     = 80
}

variable "cpuCore" {
  description = "Number of CPU cores the container can use. Can be with a maximum of two decimals."
  type        = string
  default     = "0.5"
}

variable "memorySize" {
  description = "Amount of memory (in gibibytes, GiB) allocated to the container up to 4GiB. Can be with a maximum of two decimals. Ratio with CPU cores must be equal to 2."
  type        = string
  default     = "1"
}

variable "minReplicas" {
  description = "Minimum number of replicas that will be deployed"
  type        = number
  default     = 1
}

variable "maxReplicas" {
  description = "Maximum number of replicas that will be deployed"
  type        = number
  default     = 3
}

resource "random_string" "container_app_name" {
  length  = 8
  special = false
}

resource "random_string" "container_app_env_name" {
  length  = 8
  special = false
}

resource "random_string" "container_app_log_analytics_name" {
  length  = 8
  special = false
}

resource "azurerm_log_analytics_workspace" "logAnalytics" {
  name                = var.containerAppLogAnalyticsName
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
}

resource "azurerm_container_app_environment" "containerAppEnv" {
  name                = var.containerAppEnvName
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  app_logs_configuration {
    destination = "log-analytics"
    log_analytics_configuration {
      customer_id = azurerm_log_analytics_workspace.logAnalytics.workspace_id
      shared_key  = azurerm_log_analytics_workspace.logAnalytics.primary_shared_key
    }
  }
}

resource "azurerm_container_app" "containerApp" {
  name                = var.containerAppName
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  container_app_environment_id = azurerm_container_app_environment.containerAppEnv.id
  revision_mode                = "Single"
  template {
    revision_suffix = "firstrevision"
    container {
      name   = var.containerAppName
      image  = var.containerImage
      cpu    = var.cpuCore
      memory = "${var.memorySize}Gi"
    }
  }
  ingress {
    external_enabled = true
    target_port      = var.targetPort
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

output "containerAppFQDN" {
  value = azurerm_container_app.containerApp.configuration[0].ingress[0].fqdn
}
