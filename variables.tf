variable "tfe_token" {
  description = "Terraform Cloud/Enterprise API token"
  type        = string
  sensitive   = true
}

variable "github_token" {
  description = "GitHub Personal Access Token for OAuth client"
  type        = string
  sensitive   = true
}

variable "organization_email" {
    description = "Email used for Terraform Cloud/Enterprise organization" 
    type = string
}

variable "organization_name" {
  description = "Terraform Cloud/Enterprise organization name"
  default     = "terraform-demo-organization-assesment"
  type        = string
  
}

variable "project_name" {
  description = "Terraform Cloud/Enterprise project name"
  default     = "terraform-demo-project"
  type        = string
  
}
