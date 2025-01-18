# Managed via ADE Extensibility Model (Terraform Runner:scripts/deploy.sh) 
# ============================================================

variable "resource_group_name" {
  description = "Specifies the name of the resource group in which the App Configuration store should be created."
  type        = string
  
}

variable "ade_location" {
  description = "Specifies the Azure location where the app configuration store should be created."
  type        = string
  default     = "westus3"
}

variable "ade_env_name" {
  description = "Specifies the name of the Azure DevOps environment."
  type        = string
}

variable "env_name" {
    description = "Specifies the name of the environment."
    type        = string
}

variable "ade_subscription" {
    description = "Specifies the name of the Azure DevOps subscription."
    type        = string
}

variable "ade_environment_type" {
    description = "Specifies the type of the Azure DevOps environment."
    type        = string
}

# ============================================================

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