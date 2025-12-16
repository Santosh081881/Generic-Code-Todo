terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-santu"
    storage_account_name = "santustorage"
    container_name       = "tfstate"
    key                  = "genric.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

}
