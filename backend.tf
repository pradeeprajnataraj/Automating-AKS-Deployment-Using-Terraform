terraform {
  backend "azurerm" {
    resource_group_name  = "aksrginfra"
    storage_account_name = "aksstorageinfra1100"
    container_name       = "aksbloginfra"
    key                  = "terraform.tfstate"
  }
}
