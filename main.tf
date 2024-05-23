data "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_name  = data.azurerm_storage_account.this.name
  container_access_type = "private"
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "storage_data_contributor" {
  scope                = "${data.azurerm_storage_account.this.id}/blobServices/default/containers/${azurerm_storage_container.this.name}"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.service_principal_id
}

resource "azurerm_role_assignment" "storage_account_key_operator" {
  scope                = data.azurerm_storage_account.this.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = var.service_principal_id
}
