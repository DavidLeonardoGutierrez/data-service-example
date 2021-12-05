

#-----------------------------------------------------Terraform provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.73.0"
    }
  }
}

# For some reason terraform needs these empty features.
provider "azurerm" {
  features {}
}

#-----------------------------------------------------Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.default_region
}
