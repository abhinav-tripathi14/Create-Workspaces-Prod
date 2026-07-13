###########################################################
# Variable and variable sets creation
###########################################################
locals {
  tfc_org_name = "Test-Abhinav"
}
data "tfe_organization" "tfeorg" {
  name = local.tfc_org_name
}
#
data "tfe_oauth_client" "vcs_client" {
organization = data.tfe_organization.tfeorg.name
service_provider = "github"
}
output "org_name" {
value = data.tfe_organization.tfeorg.name
}

output "tfe_oauth_client_vcs_client_oauth_token_id" {
  value = data.tfe_oauth_client.vcs_client.oauth_token_id
}

data "tfe_project" "projname" {
  name         = "Dry-Run"
  organization = local.tfc_org_name
}

resource "tfe_variable_set" "account_values_var_set" {

  name         = "test_account"
  description  = "Acccount level variables"
  organization = data.tfe_organization.tfeorg.name
}

resource "tfe_variable" "account_id" {

  key             = "daccount_id"
  value           = "0adadfb6-215e-4626-a676-c7ed67144454"
  category        = "terraform"
  description     = "The account id value"
  variable_set_id = tfe_variable_set.account_values_var_set.id
}

resource "tfe_variable" "base_account_url" {

  key             = "base_account_url"
  value           = "https://accounts.cloud.com"
  category        = "terraform"
  description     = "account base url value"
  variable_set_id = tfe_variable_set.account_values_var_set.id
}
resource "tfe_variable" "client_id" {

  key             = "client_id"
  value           = "testclientid"
  category        = "terraform"
  description     = "The spi client id value"
  variable_set_id = tfe_variable_set.account_values_var_set.id
}

resource "tfe_variable" "client_secret" {

  key             = "client_secret"
  value           = "testsecret"
  category        = "terraform"
  description     = "The  spi client secret value"
  variable_set_id = tfe_variable_set.account_values_var_set.id
  sensitive       = true
}
