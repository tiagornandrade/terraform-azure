terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.31.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "animals-group"
  location = "brazilsouth"
  tags = {
    enviroment = "dev"
    source     = "Terraform"
    owner      = "Tiago Navarro"
  }
}