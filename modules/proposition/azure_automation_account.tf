data "azurerm_resource_group" "edi_platform" {
  name = var.edi_platform_resource_group_name
}

resource "random_string" "automation_account_name" {
  length  = 10
  number  = true
  special = false
}

locals {
  automation_account_name = "edisp-${random_string.automation_account_name.result}"
}

resource "azurerm_automation_account" "proposition" {

  name                = local.automation_account_name
  location            = data.azurerm_resource_group.edi_platform.location
  resource_group_name = data.azurerm_resource_group.edi_platform.name
  sku_name            = "Basic"

  tags = local.tags
}

resource "azurerm_role_assignment" "automation_account_edisp_admin_contributor" {
  scope                = azurerm_automation_account.proposition.id
  role_definition_name = "Contributor"
  principal_id         = var.edi_platform_admin_group
}

resource "azurerm_role_assignment" "automation_account_proposition_reader" {
  for_each = toset(var.azure_object_ids)

  scope                = azurerm_automation_account.proposition.id
  role_definition_name = "Reader"
  principal_id         = each.key
}

resource "azurerm_automation_variable_string" "proposition_org" {
  #checkov:skip=CKV_AZURE_73:Var cannot be encrypted as it needs to be retrieved
  name                    = "${var.env_prefix}-ORG-ID"
  resource_group_name     = data.azurerm_resource_group.edi_platform.name
  automation_account_name = local.automation_account_name
  value                   = hsdp_iam_org.proposition.id
}

resource "azurerm_automation_variable_string" "cdr_url" {
  #checkov:skip=CKV_AZURE_73:Var cannot be encrypted as it needs to be retrieved
  name                    = "${var.env_prefix}-CDR-URL"
  resource_group_name     = data.azurerm_resource_group.edi_platform.name
  automation_account_name = local.automation_account_name
  value                   = var.cdr_base_url
}

resource "azurerm_automation_variable_string" "dicom_store_urls" {
  #checkov:skip=CKV_AZURE_73:Var cannot be encrypted as it needs to be retrieved

  for_each = toset(["wado","qido","stow","config","datamgmt"])

  name                    = "${var.env_prefix}-DICOMSTORE-${upper(each.key)}-URL"
  resource_group_name     = data.azurerm_resource_group.edi_platform.name
  automation_account_name = local.automation_account_name
  value                   = "https://dss-${each.key}-${var.dicom_store_instance_name}.us-east.philips-healthsuite.com"
}


resource "azurerm_automation_variable_string" "tenants" {
  #checkov:skip=CKV_AZURE_73:Var cannot be encrypted as it needs to be retrieved
  name                    = "${var.env_prefix}-TENANTS"
  resource_group_name     = data.azurerm_resource_group.edi_platform.name
  automation_account_name = local.automation_account_name
  value                   = jsonencode(var.iam_tenant_orgs)
}
