terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "events" {
  name     = "events-rg"
  location = "brazilsouth"
  tags = {
    enviroment = "dev"
    source     = "Terraform"
    owner      = "Tiago Navarro"
  }
}

resource "azurerm_eventhub_namespace" "events" {
  name                = "acceptanceFakeEventHubNamespace"
  location            = azurerm_resource_group.events.location
  resource_group_name = azurerm_resource_group.events.name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "events" {
  name                = "acceptanceFakeEventHub"
  namespace_name      = azurerm_eventhub_namespace.events.name
  resource_group_name = azurerm_resource_group.events.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_storage_account" "events" {
  name                     = "stgevents"
  resource_group_name      = azurerm_resource_group.events.name
  location                 = azurerm_resource_group.events.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "events" {
  name                  = "dev"
  storage_account_name  = azurerm_storage_account.events.name
  container_access_type = "private"
}

resource "azurerm_data_factory" "events" {
  name                = "factory-events"
  location            = azurerm_resource_group.events.location
  resource_group_name = azurerm_resource_group.events.name
}

resource "azurerm_databricks_workspace" "events" {
  name                = "databricks-events"
  resource_group_name = azurerm_resource_group.events.name
  location            = azurerm_resource_group.events.location
  sku                 = "standard"

  tags = {
    Environment = "Production"
  }
}