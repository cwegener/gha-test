terraform {
  backend "azurerm" {
    storage_account_name = "" # Github Action Secret: `TF_STATE_STORAGE_ACCOUNT`
    resource_group_name  = "" # Github Action Variable: `TF_STATE_RESOURCE_GROUP_NAME`
    container_name       = "gha-test"
    key                  = "terraform.tfstate"
  }
}
