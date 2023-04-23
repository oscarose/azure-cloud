# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7d9fa66f-c035-47fb-95c8-8826cc02c0da"
}

provider "azuread" {
}

