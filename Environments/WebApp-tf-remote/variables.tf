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
# variable "remote_state_rg" {
#     description = "Specifies the resource group name for the remote state."
#     type        = string
# }

# variable "remote_state_sa" {
#     description = "Specifies the storage account name for the remote state."
#     type        = string
# }

# variable "remote_state_container" {
#     description = "Specifies the container name for the remote state."
#     type        = string
#     default = "tfstate"
# }

# variable "remote_state_key" {
#     description = "Specifies the key for the remote state."
#     type        = string
#     default     = "deploy.tfstate"
# }

# ============================================================
variable "name" {
  description = "Specifies the name of the App Configuration store."
  type        = string
}

variable "location" {
  description = "Optional override for ade_location"
  type = string
  default = ""
}

variable "tags" {
  description = "Adds tags for the key-value resources. It's optional"
  type        = map(string)
  default     = {
    tag1 = "tag-value-1"
    tag2 = "tag-value-2"
  }
}

