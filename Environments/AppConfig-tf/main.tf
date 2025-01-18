
provider "azurerm" {
  features {}
  subscription_id = var.ade_subscription
}

locals {
  tags = {
    environment = var.env_name
    ade_environment = var.ade_env_name
    ade_environment_type = var.ade_environment_type
    ade_subscription = var.ade_subscription
  }
}
