resource "azurerm_storage_account" "storageaccount" {
  name                     = "${var.project}storeaccount"
  resource_group_name      = var.resourcegroupname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = "${var.project}storecontainer"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"

}

resource "azurerm_storage_management_policy" "storageaccountpolicy" {
  storage_account_id = azurerm_storage_account.storageaccount.id

  rule {
    name    = "archiveOriginalImage"
    enabled = true
    filters {
      prefix_match = ["${var.project}storecontainer/original"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 2
        tier_to_archive_after_days_since_modification_greater_than = 5
      }
    }
  }
}