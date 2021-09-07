data "hsdp_iam_org" "edi_platform" {
  organization_id = var.edi_platform_org_id
}
// This is an empty role required to allow the manual addition of CLIENT.SCOPES permission via HSDP ticket
// see more in docs/client_scopes.md
resource "hsdp_iam_role" "client_scopes" {
  managing_organization = data.hsdp_iam_org.edi_platform.id
  name                  = "CLIENT_SCOPES"
  description           = "Role to allow propositions to have CLIENT.SCOPES permission on the Org"
  permissions           = []
}

// This is a group for all proposition service identities to give them roles at the EDI Platform root org level
resource "hsdp_iam_group" "proposition_services" {
  managing_organization = data.hsdp_iam_org.edi_platform.id
  name                  = "edisp_proposition_services"
  description           = "EDISP proposition service identiies created by terraform and used for proposition automation"
  services              = [for p in module.proposition : p.service_id]
  roles                 = [hsdp_iam_role.client_scopes.id]
}

module "proposition" {
  source = "./modules/proposition"

  for_each = {
    for proposition in var.propositions :
    proposition.name => proposition
  }

  azure_object_ids                 = each.value.azure_object_ids
  cdr_base_url                     = var.cdr_base_url
  description                      = each.value.description
  edi_platform_admin_group         = var.edi_platform_admin_group
  edi_platform_org_id              = var.edi_platform_org_id
  edi_platform_resource_group_name = var.edi_platform_resource_group_name
  env_prefix                       = local.env_prefix
  environment                      = var.environment
  iam_tenant_orgs                  = var.iam_tenant_orgs
  name                             = each.key
  region                           = var.region
}

// Add groups in tenant orgs and add service Ids here
resource "hsdp_iam_group" "propositions" {
  for_each = {
    for tenant in var.iam_tenant_orgs :
    tenant.id => tenant
  }

  managing_organization = each.key
  name                  = "philips_propositions"
  description           = "Group for all Philips proposition automation users."
  roles                 = [hsdp_iam_role.propositions[each.key].id]
  services              = [for p in module.proposition : p.service_id]
}

resource "hsdp_iam_role" "propositions" {
  for_each = {
    for tenant in var.iam_tenant_orgs :
    tenant.id => tenant
  }

  name        = "PHIPROP"
  description = "Role for Philips Proposition automation service identities within the onboarded tenants."

  permissions = [
    "GROUP.READ",
    "GROUP.WRITE",
    "ROLE.READ",
    "ROLE.WRITE",
    "SERVICE.DELETE",
    "SERVICE.READ",
    "SERVICE.SCOPE",
    "SERVICE.WRITE",
  ]

  managing_organization = each.key
}

