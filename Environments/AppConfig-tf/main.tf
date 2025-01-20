
provider "azurerm" {
  features {}
  subscription_id = var.ade_subscription
}

locals {
  location = coalesce(var.location, var.ade_location)
  tags = {
    environment = var.env_name
    ade_environment = var.ade_env_name
    ade_environment_type = var.ade_environment_type
    ade_subscription = var.ade_subscription
  }
}
terraform {
  backend "azurerm" {
    resource_group_name   = var.remote_state_rg
    storage_account_name  = var.remote_state_sa
    container_name        = var.remote_state_container
    key                   = "${var.env_name}/${var.ade_environment_type}/${var.env_name}/${var.remote_state_key}"
  }
}