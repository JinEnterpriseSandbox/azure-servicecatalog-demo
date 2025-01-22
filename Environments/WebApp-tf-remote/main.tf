
provider "azurerm" {
  features {}
  use_msi = true
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
  }

}