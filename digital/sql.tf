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

resource "azurerm_mssql_database" "database" {
  name                        = "raph-database"
  server_id                   = azurerm_mssql_server.sqlsrv.id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  min_capacity                = 1
  max_size_gb                 = 4
  sku_name                    = "GP_S_Gen5_2"
  zone_redundant              = true
}

# Deployer un MSSQL_Database sur votre MSSQL_Server 

# sku_name = GP_S_Gen5_2 


# git raphaeldeletoille