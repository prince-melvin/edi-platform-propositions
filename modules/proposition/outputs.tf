output "azure_automation_account" {
  value = {
    name                = azurerm_automation_account.proposition.name
    resource_group_name = azurerm_automation_account.proposition.resource_group_name
  }
  description = "The connection details for the azure automation account created for the proposition"
}

output "azure_keyvault" {
  value = {
    vault_uri : azurerm_key_vault.proposition.vault_uri
  }
  description = "The connection details for the azure keyvault created for the proposition"
}

output "service_id" {
  value       = hsdp_iam_service.proposition.id
  description = "The ID of the service created for this proposition."
}

output "org_id" {
  value       = hsdp_iam_org.proposition.id
  description = "The ID of the organisation created for this proposition."
}


