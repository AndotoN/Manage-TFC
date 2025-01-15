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
