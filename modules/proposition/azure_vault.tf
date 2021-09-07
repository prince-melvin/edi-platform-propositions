data "azurerm_client_config" "current" {}

resource "random_string" "vault_name" {
  length  = 10
  number  = true
  special = false
}

resource "azurerm_key_vault" "proposition" {
  #checkov:skip=CKV_AZURE_109:Access is required from many locations

  name                        = "edisp-${random_string.vault_name.result}"
  location                    = data.azurerm_resource_group.edi_platform.location
  resource_group_name         = data.azurerm_resource_group.edi_platform.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  enable_rbac_authorization   = true
  sku_name                    = "standard"
  tags                        = local.tags
}

resource "azurerm_role_assignment" "edisp_admin_keyvault_admin" {
  scope                = azurerm_key_vault.proposition.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.edi_platform_admin_group
}

resource "azurerm_role_assignment" "proposition_reader" {
  for_each = toset(var.azure_object_ids)

  scope                = azurerm_key_vault.proposition.id
  role_definition_name = "Reader"
  principal_id         = each.key
}

resource "azurerm_role_assignment" "proposition_keyvault_users" {
  for_each = toset(var.azure_object_ids)

  scope                = azurerm_key_vault.proposition.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.key
}

resource "azurerm_key_vault_secret" "service_id" {
  #checkov:skip=CKV_AZURE_41:Secret does not expire

  name         = "${var.env_prefix}-SERVICE-ID"
  value        = hsdp_iam_service.proposition.service_id
  key_vault_id = azurerm_key_vault.proposition.id
  content_type = "text/plain"
  tags         = local.tags

  depends_on = [
    azurerm_role_assignment.edisp_admin_keyvault_admin
  ]
}

resource "azurerm_key_vault_secret" "service_key" {
  #checkov:skip=CKV_AZURE_41:Secret does expire but unable to get expiry time easily. TODO fix when philips-software/terraform-provider-hsdp#94 is resolved

  name         = "${var.env_prefix}-SERVICE-KEY"
  value        = hsdp_iam_service.proposition.private_key
  key_vault_id = azurerm_key_vault.proposition.id
  content_type = "text/plain"
  tags         = local.tags

  depends_on = [
    azurerm_role_assignment.edisp_admin_keyvault_admin
  ]
}
