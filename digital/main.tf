# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.43.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# terraform init 

# terraform apply

# terraform destroy

# terraform validate 

resource "azurerm_resource_group" "rg" {
  name     = "raphaeld"
  location = "West Europe"
}

#Azure Storage Explorer 
resource "azurerm_storage_account" "storage" {
  name                     = "ohsqfijiqosjfisqf"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Cool"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
  name                        = "raphvault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Delete", "List", "Purge", "Recover", "Restore", "Set"
    ]

  }
}

# Deployer un MSSQL SERVER avec terraform 

# terraform apply -auto-approve 

#Deployer 10 resource group à partir d'un seul bloc --> count 

resource "azurerm_resource_group" "allrg" {
  count    = 10
  name     = "${var.myname}rg${count.index}"
  location = "West Europe"
}

# Deployer 3 resource group avec for_each et une variable de type map 
# 1 en West Europe 
# 1 en france central 
# 1 en West US 

# resource "azurerm_resource_group" "allrg" {

#   for_each = var.allrg
#   name     = each.value.name
#   location = each.value.location
# }



en Terraform --> Déployer un Log Analytics et récupérer les Metrics de votre Storage Account avec Diagnostic Settings // Resource Group 



terraform 
download terraform sur https://developer.hashicorp.com/terraform/downloads 
a ajouter dans ses variables d'environnement (Path)
pour test, ouvrir cmd --> terraform version


az cli https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
Suivant, Suivant, Suivant 
pour test, ouvrir cmd --> az version


kubectl 1.24 
https://dl.k8s.io/v1.24.0/bin/windows/amd64/kubectl.exe.sha256
pour test, kubectl --version 




 

