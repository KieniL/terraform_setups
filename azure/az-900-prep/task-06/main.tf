terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource.prefix}-rg"
  location = var.resource.location
  tags = {
    project = var.resource.project
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource.prefix}-vnet"
  address_space       = ["10.7.29.0/29"]
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource.prefix}--subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.7.29.0/29"]
  service_endpoints    = ["Microsoft.Sql"]


}


resource "azurerm_mssql_server" "sqlserver" {
  name                         = "${var.resource.prefix}-sqlserver"
  location                     = var.resource.location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = "sqluser"
  administrator_login_password = "Pa$$w0rd1234"

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "az90010examplesalk"
  location                 = var.resource.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_database" "sqldb" {
  name           = "${var.resource.prefix}-sqldatabase"
  server_id      = azurerm_mssql_server.sqlserver.id
  max_size_gb    = 4
  read_scale     = true
  zone_redundant = true

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_mssql_database_extended_auditing_policy" "auditingpolicy" {
  database_id                             = azurerm_mssql_database.sqldb.id
  storage_endpoint                        = azurerm_storage_account.storage.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.storage.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                = "sql-vnet-rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.sqlserver.name
  subnet_id           = azurerm_subnet.subnet.id

}