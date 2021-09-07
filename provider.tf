provider "hsdp" {
  region              = "us-east"
  environment         = "client-test"
  service_id          = ""//automation account
  service_private_key = ""//private key
  debug_log           = "C:\\temp\\terraform.log"
}

provider "azurerm" {
  features {}
 
} # This provider is configuered by environment secrets managed by the calling configuration