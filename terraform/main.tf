terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "nvs-rg" {
  name     = "nvs-rg"
  location = "West Us"
  tags = {
    environment = "dev"
  }
}


resource "azurerm_virtual_network" "nvs-net" {
  name                = "nvs-network"
  resource_group_name = azurerm_resource_group.nvs-rg.name
  location            = azurerm_resource_group.nvs-rg.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "dev"
  }
}


resource "azurerm_subnet" "nvs-subnet" {
  name                 = "nvs-subnet"
  resource_group_name  = azurerm_resource_group.nvs-rg.name
  virtual_network_name = azurerm_virtual_network.nvs-net.name
  address_prefixes     = ["10.0.1.0/24"]


}


