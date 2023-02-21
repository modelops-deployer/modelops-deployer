terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.44.1"
    }
  }
  backend "azurerm" {}
  required_version = ">= 1.1.0"
}

