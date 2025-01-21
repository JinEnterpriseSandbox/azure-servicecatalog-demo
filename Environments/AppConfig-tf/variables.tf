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
  default = null
}

variable "keyValues" {
    description = "Specifies the key-value pairs for the App Configuration store."
    type = list(object({
        key   = string
        value = string
    }))
    default = [
        { key = "myKey", value = "Key-value without label" },
        { key = "myKey$myLabel", value = "Key-value with label" }
    ]
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

