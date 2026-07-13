locals {
  tfc_org_name = "Test-Abhinav"
}
data "tfe_organization" "databricks" {
  name = local.tfc_org_name
}
#
data "tfe_oauth_client" "vcs_client" {
organization = data.tfe_organization.databricks.name
service_provider = "github"
name = "Github-dryrun"
}
output "org_name" {
value = data.tfe_organization.databricks.name
}

output "tfe_oauth_client_vcs_client_oauth_token_id" {
  value = data.tfe_oauth_client.vcs_client.oauth_token_id
}

data "tfe_project" "projname" {
  name         = "Dry-Run"
  organization = local.tfc_org_name
}

resource "tfe_workspace" "ws_workspace" {

  name         = "Workspace-1" # each.value.ws_name
  organization = local.tfc_org_name
  description  = "New databricks workspace" 
  tag_names = ["databricks-workspace"]
  working_directory = "databricks-workspaces-new"
  auto_apply        = true
  terraform_version = "~>1.8.0"

  project_id          = data.tfe_project.projname.id
  global_remote_state = false

  vcs_repo {
    identifier     = "abhinav-tripathi14/Create-Workspaces-Prod"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.vcs_client.oauth_token_id
  }
  trigger_patterns = ["databricks-workspaces-new/*", "modules/*"]

  lifecycle {
    ignore_changes = [
      auto_apply
    ]
  }
}


