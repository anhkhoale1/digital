resource "azurerm_mssql_server" "sqlsrv" {
  name                         = "raphsqlsrv"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "raphlogin"
  administrator_login_password = random_password.password.result
  minimum_tls_version          = "1.2"

  #   azuread_administrator {
  #     login_username = "AzureAD Admin"
  #     object_id      = data.azurerm_client_config.current.object_id
  #   }

}

resource "random_password" "password" {
  length           = 16
  special          = true
  min_lower        = 1
  min_special      = 1
  min_numeric      = 1
  min_upper        = 1
  override_special = "!"
}

resource "azurerm_key_vault_secret" "mdpsql" {
  name         = "mdpsql"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.vault.id
}

# Ajouter votre MDP à votre Keyvault. 

#Assigner à votre MSSQL Serveur un MDP Aléatoire :

# 16 carac
# 1 maj min 
# 1 min min 
# 1 chiffre min 
# 1 ! min 



