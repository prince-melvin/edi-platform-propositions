# Proposition Module

This is an internal private module for the EDI Platform Core module to provision the resources required for a new proposition.

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0    |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >= 2.67.0 |
| <a name="requirement_hsdp"></a> [hsdp](#requirement_hsdp)                | >= 0.18.2 |

## Providers

| Name                                                         | Version   |
| ------------------------------------------------------------ | --------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 2.67.0 |
| <a name="provider_hsdp"></a> [hsdp](#provider_hsdp)          | >= 0.18.2 |
| <a name="provider_random"></a> [random](#provider_random)    | n/a       |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                  | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_automation_account.proposition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account)                          | resource    |
| [azurerm_automation_variable_string.cdr_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_string)              | resource    |
| [azurerm_automation_variable_string.proposition_org](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_string)      | resource    |
| [azurerm_automation_variable_string.tenants](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_string)              | resource    |
| [azurerm_key_vault.proposition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)                                            | resource    |
| [azurerm_key_vault_secret.service_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)                               | resource    |
| [azurerm_key_vault_secret.service_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)                              | resource    |
| [azurerm_role_assignment.automation_account_edisp_admin_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource    |
| [azurerm_role_assignment.automation_account_proposition_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)      | resource    |
| [azurerm_role_assignment.edisp_admin_keyvault_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                 | resource    |
| [azurerm_role_assignment.proposition_keyvault_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                 | resource    |
| [azurerm_role_assignment.proposition_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                         | resource    |
| [hsdp_iam_application.proposition](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_application)                               | resource    |
| [hsdp_iam_group.proposition](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_group)                                           | resource    |
| [hsdp_iam_org.proposition](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_org)                                               | resource    |
| [hsdp_iam_proposition.proposition](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_proposition)                               | resource    |
| [hsdp_iam_role.proposition](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_role)                                             | resource    |
| [hsdp_iam_service.proposition](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_service)                                       | resource    |
| [random_string.automation_account_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)                                        | resource    |
| [random_string.vault_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)                                                     | resource    |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)                                     | data source |
| [azurerm_resource_group.edi_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                              | data source |
| [hsdp_iam_org.edi_platform](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/iam_org)                                           | data source |

## Inputs

| Name                                                                                                                              | Description                                                                                                                                                                           | Type                                                               | Default | Required |
| --------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | ------- | :------: |
| <a name="input_azure_object_ids"></a> [azure_object_ids](#input_azure_object_ids)                                                 | A list of azure object ids that will be granted access to azure resources created by this module. A group is recommended but these can be individuals, groups, service principals etc | `list(string)`                                                     | n/a     |   yes    |
| <a name="input_cdr_base_url"></a> [cdr_base_url](#input_cdr_base_url)                                                             | Base url for the CDR on HSDP.                                                                                                                                                         | `string`                                                           | n/a     |   yes    |
| <a name="input_description"></a> [description](#input_description)                                                                | The description of the proposition                                                                                                                                                    | `string`                                                           | n/a     |   yes    |
| <a name="input_edi_platform_admin_group"></a> [edi_platform_admin_group](#input_edi_platform_admin_group)                         | The ObjectID of the EDI Platform admins group                                                                                                                                         | `string`                                                           | n/a     |   yes    |
| <a name="input_edi_platform_org_id"></a> [edi_platform_org_id](#input_edi_platform_org_id)                                        | The UUID for the EDI Platform root IAM org                                                                                                                                            | `string`                                                           | n/a     |   yes    |
| <a name="input_edi_platform_resource_group_name"></a> [edi_platform_resource_group_name](#input_edi_platform_resource_group_name) | The name of the resoruce group in Azure that holds the resources for EDI Platform                                                                                                     | `string`                                                           | n/a     |   yes    |
| <a name="input_env_prefix"></a> [env_prefix](#input_env_prefix)                                                                   | Prefix to be used to uniquely reference this deployment when creating or accessing keys. To prevent clashes between environments.                                                     | `string`                                                           | n/a     |   yes    |
| <a name="input_environment"></a> [environment](#input_environment)                                                                | HSDP environment that this will be deployed to (one of client-test or prod)                                                                                                           | `string`                                                           | n/a     |   yes    |
| <a name="input_iam_tenant_orgs"></a> [iam_tenant_orgs](#input_iam_tenant_orgs)                                                    | A list of tenant orgs to onboard onto the platform and automate.                                                                                                                      | <pre>list(object({<br> name = string<br> id = string<br> }))</pre> | n/a     |   yes    |
| <a name="input_name"></a> [name](#input_name)                                                                                     | The name of the proposition                                                                                                                                                           | `string`                                                           | n/a     |   yes    |
| <a name="input_region"></a> [region](#input_region)                                                                               | HSDP region that this will be deployed to                                                                                                                                             | `string`                                                           | n/a     |   yes    |

## Outputs

| Name                                                                                                        | Description                                                                         |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| <a name="output_azure_automation_account"></a> [azure_automation_account](#output_azure_automation_account) | The connection details for the azure automation account created for the proposition |
| <a name="output_azure_keyvault"></a> [azure_keyvault](#output_azure_keyvault)                               | The connection details for the azure keyvault created for the proposition           |
| <a name="output_org_id"></a> [org_id](#output_org_id)                                                       | The ID of the organisation created for this proposition.                            |
| <a name="output_service_id"></a> [service_id](#output_service_id)                                           | The ID of the service created for this proposition.                                 |
