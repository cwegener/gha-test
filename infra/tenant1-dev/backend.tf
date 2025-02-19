terraform {
  backend "azurerm" {
    storage_account_name = ""
    container_name       = "gha-test"
    key                  = "terraform.tfstate"
  }
}
