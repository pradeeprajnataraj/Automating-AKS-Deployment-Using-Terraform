 # resource "azurerm_storage_account" "tfstate" {
 # name                     = "aksstorageinfra1100"  # must be globally unique, no underscores
 # resource_group_name      = "aksrginfra"
 # location                 = "eastus"
 # account_tier             = "Standard"
 # account_replication_type = "LRS"
 # }

 resource "azurerm_storage_container" "tfstate" {
  name                  = "aksbloginfra"
  storage_account_id    = "/subscriptions/a7227ddf-a84b-488c-9757-267492f738eb/resourceGroups/aksrginfra/providers/Microsoft.Storage/storageAccounts/aksstorageinfra1100"
  container_access_type = "private"
 }