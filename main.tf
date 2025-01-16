terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.62.0" 
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io" 
  token    = var.tfe_token      
}

resource "tfe_organization" "demo-organization" {
  name  = var.organization_name
  email = var.organization_email
}

resource "tfe_project" "demo-project" {
  organization = tfe_organization.demo-organization.name
  name = var.project_name
}

resource "tfe_workspace" "cli-workspace-1" {
    name = "cli-driven-workflow-1"
    organization = var.organization_name
    project_id = tfe_project.demo-project.id
}

resource "tfe_workspace" "cli-workspace-2" {
    name = "cli-driven-workflow-2"
    organization = var.organization_name
    project_id = tfe_project.demo-project.id
}

resource "tfe_workspace" "cli-workspace-3" {
    name = "cli-driven-workflow-3"
    organization = var.organization_name
    project_id = tfe_project.demo-project.id
}

resource "tfe_oauth_client" "client" {
  organization     = tfe_organization.demo-organization.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_token
  service_provider = "github"
}

resource "tfe_workspace" "vcs-workspace" {
  name                 = "vcs-driven-workflow"
  organization         = tfe_organization.demo-organization.name
  project_id           = tfe_project.demo-project.id
  vcs_repo {
    branch             = "main"
    identifier         = "AndotoN/Manage-TFC"
    oauth_token_id     = tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_variable_set" "cli_variable_set" {       # A variable set is declared and applied to all CLI-driven workspaces
  name = "Cli Variable Set"
  description = "This variable set is created using CLI"
  organization = tfe_organization.demo-organization.name
  workspace_ids = [
    tfe_workspace.cli-workspace-1.id,
    tfe_workspace.cli-workspace-2.id,
    tfe_workspace.cli-workspace-3.id,
  ]
}

resource "tfe_variable" "organization_name" {         # This terraform variable is stored on the Terraform Cloud for all CLI-driven workspaces
  key = "organization_name"                         
  value = "terraform-demo-organization-assesment"  
  category = "terraform"
  variable_set_id = tfe_variable_set.cli_variable_set.id
}

resource "tfe_variable" "project_name" {              # This terraform variable is stored on the Terraform Cloud for all CLI-driven workspaces
  key = "project_name"                              
  value = "terraform-demo-project"  
  category = "terraform"
  variable_set_id = tfe_variable_set.cli_variable_set.id 
}

resource "tfe_variable" "tfe_token" {                # This environment variable is stored on the Terraform Cloud for all CLI-driven workspaces
  key             = "TFE_TOKEN"
  value           = var.tfe_token
  category        = "env"
  variable_set_id = tfe_variable_set.cli_variable_set.id
  sensitive       = true
}

resource "tfe_variable" "github_token" {             # This environment variable is stored on the Terraform Cloud for all CLI-driven workspaces
  key             = "GITHUB_TOKEN"
  value           = var.github_token
  category        = "env"
  variable_set_id = tfe_variable_set.cli_variable_set.id
  sensitive       = true
}
