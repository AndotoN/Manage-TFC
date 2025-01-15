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

resource "tfe_organization" "andrian-organization" {
  name  = "terraform-practice-organization"
  email = "andriannikolaev98@gmail.com"
}

resource "tfe_project" "andrian-project" {
  organization = tfe_organization.andrian-organization.name
  name = "andrian-project"
}

resource "tfe_workspace" "workspace-1" {
    name = "cli-driven-workflow-1"
    organization = tfe_organization.andrian-organization.name
    project_id = tfe_project.andrian-project.id
}

resource "tfe_workspace" "workspace-2" {
    name = "cli-driven-workflow-2"
    organization = tfe_organization.andrian-organization.name
    project_id = tfe_project.andrian-project.id
}

resource "tfe_workspace" "workspace-3" {
    name = "cli-driven-workflow-3"
    organization = tfe_organization.andrian-organization.name
    project_id = tfe_project.andrian-project.id
}
resource "tfe_workspace_settings" "workspace-1-settings" {
    workspace_id = tfe_workspace.workspace-1.id
    execution_mode = "remote"
}

resource "tfe_oauth_client" "client" {
  organization     = tfe_organization.andrian-organization.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_token
  service_provider = "github"
}

resource "tfe_workspace" "vcs-workspace" {
  name                 = "vcs-driven-workflow"
  organization         = tfe_organization.andrian-organization.name
  project_id           = tfe_project.andrian-project.id
  vcs_repo {
    branch             = "main"
    identifier         = "AndotoN/Manage-TFC"
    oauth_token_id     = tfe_oauth_client.client.oauth_token_id
  }
}