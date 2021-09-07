data "hsdp_iam_org" "edi_platform" {
  organization_id = var.edi_platform_org_id
}

resource "hsdp_iam_org" "proposition" {
  name          = substr(upper(var.name), 0, 20)
  description   = var.description
  parent_org_id = data.hsdp_iam_org.edi_platform.id
}

resource "hsdp_iam_proposition" "proposition" {
  name            = "AUTOMATION"
  description     = var.description
  organization_id = hsdp_iam_org.proposition.id
}

resource "hsdp_iam_application" "proposition" {
  name           = "AUTOMATION"
  description    = "Automation app for ${var.name}"
  proposition_id = hsdp_iam_proposition.proposition.id
}

resource "hsdp_iam_service" "proposition" {
  name           = substr(var.name, 0, 64)
  description    = "Automation service for ${var.name}"
  application_id = hsdp_iam_application.proposition.id
  validity       = 12
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

resource "hsdp_iam_role" "proposition" {
  managing_organization = hsdp_iam_org.proposition.id
  name                  = "PROP_ADMIN_ROLE"
  description           = "Permissions to create IAM resources below the provided proposition."
  permissions = [
    "APPLICATION.DELETE",
    "APPLICATION.READ",
    "APPLICATION.WRITE",
    "CLIENT.DELETE",
    "CLIENT.READ",
    "CLIENT.WRITE",
    "GROUP.READ",
    "GROUP.WRITE",
    "HSDP_IAM_ORGANIZATION.CREATE",
    "HSDP_IAM_ORGANIZATION.DELETE",
    "HSDP_IAM_ORGANIZATION.READ",
    "HSDP_IAM_ORGANIZATION.UPDATE",
    "PROPOSITION.READ",
    "PROPOSITION.WRITE",
    "ROLE.READ",
    "ROLE.WRITE",
    "SERVICE.DELETE",
    "SERVICE.READ",
    "SERVICE.SCOPE",
    "SERVICE.WRITE",
  ]
}

resource "hsdp_iam_group" "proposition" {
  managing_organization = hsdp_iam_org.proposition.id
  name                  = "PROP_ADMIN_GROUP"
  description           = var.description
  services              = [hsdp_iam_service.proposition.id]
  roles                 = [hsdp_iam_role.proposition.id]
}

//Changes
//1. PROP_ADMIN_GROUP name change from prop name
//2. PROP_ADMIN_ROLE
// LOG Detail removed
// Dicom details added
