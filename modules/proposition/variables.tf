locals {
  tags = {
    "environment"      = var.environment
    "region"           = var.region
    "source"           = "terraform"
    "proposition_name" = var.name
  }
}

variable "name" {
  type        = string
  description = "The name of the proposition"
}

variable "description" {
  type        = string
  description = "The description of the proposition"
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

variable "edi_platform_org_id" {
  type        = string
  description = "The UUID for the EDI Platform root IAM org"
}

variable "env_prefix" {
  type        = string
  description = "Prefix to be used to uniquely reference this deployment when creating or accessing keys. To prevent clashes between environments."
}

variable "azure_object_ids" {
  type        = list(string)
  description = "A list of azure object ids that will be granted access to azure resources created by this module. A group is recommended but these can be individuals, groups, service principals etc"
}

variable "edi_platform_admin_group" {
  type        = string
  description = "The ObjectID of the EDI Platform admins group"
}

variable "dicom_store_instance_name" {
  description = "The name of the dedicated dicom store instance"
  type        = string
  default   =   "edisa-preview"
}