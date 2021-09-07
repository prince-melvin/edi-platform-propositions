locals {
  env_prefix = upper("${var.environment}-${var.region}")
}

variable "region" {
  type        = string
  description = "HSDP region that this will be deployed to"
}

variable "environment" {
  type        = string
  description = "HSDP environment that this will be deployed to (one of client-test or prod)"
}

variable "edi_platform_resource_group_name" {
  type        = string
  description = "The name of the resoruce group in Azure that holds the resources for EDI Platform"
}

variable "cdr_base_url" {
  type        = string
  description = "Base url for the CDR on HSDP."
}

variable "iam_tenant_orgs" {
  type = list(object({
    name = string
    id   = string
  }))
  description = "A list of tenant orgs to onboard onto the platform and automate."
}

variable "propositions" {
  type = list(object({
    name             = string
    description      = string
    azure_object_ids = list(string)
  }))
  default     = []
  description = "A list of propositions that will be onboarded and provisioned with resources and credentials for automation."
}


variable "edi_platform_org_id" {
  type        = string
  description = "The UUID for the EDI Platform root IAM org"
}


variable "edi_platform_admin_group" {
  type        = string
  description = "The ObjectID of the EDI Platform admins group"
}
