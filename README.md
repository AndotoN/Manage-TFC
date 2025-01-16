# Interview Assessment - HCP Terraform
## Andrian Nikolaev for Support Enginner at HashiCorp

## Install Terraform
1. Install Terraform using the [HashiCorp](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) documentation.
### For Windows with Chocolatey
2. Install Chocolatey using the [official Chocolatey](https://chocolatey.org/install) documentation.
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

3. Install Terraform with Chocolatey
```
choco install terraform
```

## Clone project
```
git clone https://github.com/AndotoN/Manage-TFC.git
cd Manage-TFC
```

## Create GitHub PAT token
1. Login in [GitHub](https://github.com/)
2. Go to "Settings" (By pressing on you account icon on the top right corner)
3. Go to "Developer settings" (Last option on the left side menu)
4. Go to "Personal access tokens" (classic option)
5. Generate a new token using the following scopes enabled
    * repo
    * workflow
6. Store the token securely


## Generate TFE token
1. Login on the [HCP Terraform](https://app.terraform.io/session)
2. Go to "Account settings" (By pressing on the account icon on the top left corner)
3. Go to "Tokens" (Last option on the left side menu)
4. Create new API token
5. Store the token securely


## Create environment variables
1. Open the GitHub cloned repository (Either with an IDE, PowerShell or Bash)
2. Create three environment variables for the GitHub PAT token, TFE token and the email used for the HCP Terraform Login
### Using PowerShell
```
$env:TF_VAR_tfe_token="your-terraform-cloud-token"
$env:TF_VAR_github_token="your-github-token"
$env:TF_VAR_organization_email="your-email"

$env:TF_VAR_tfe_token
$env:TF_VAR_github_token
$env:TF_VAR_organization_email
```

### Using Bash
```
export TF_VAR_tfe_token="your-terraform-cloud-token"
export TF_VAR_github_token="your-github-token"
export TF_VAR_organization_email="your-email"

echo $TF_VAR_tfe_token
echo $TF_VAR_github_token
echo $TF_VAR_organization_email
```

If you are able to see your tokens and email as environment variables, then you can proceed with the next step. Consider that these environment variables are only temporary and will be removed wheneve the terminal is closed.
Alternitavely, you can provide values for these variables during the execution of the following Terraform commands. However, with this approach they will not be stored in the variable set that is applied to the CLI-driven workspaces.

Currently the name of the organization and the project that is going to hold the workspaces are also set as variables with default values:
- **Organization name**: `terraform-demo-organization-assesment`
- **Project name**: `terraform-demo-project`
If you wish to apply different namings for the organization and project you can create additional environment variables, which will be used instead of these default values.
### Using PowerShell
```
$env:TF_VAR_organization_name="desired-organization-name"
$env:TF_VAR_project_name="desired-project-name"
```
### Using Bash
```
export TF_VAR_organization_name="desired-organization-name"
export TF_VAR_project_name="desired-project-name"
```


## Run Terraform commands
After the project is successfully cloned from GitHub and the environment variables are set - execute the following commands to create the organization, project and workspaces mentioned in the Assesment Task:
```
terraform init
terraform validate
terraform plan
terraform apply
```


## View results on the Terraform Cloud UI
If the result of the Terraform commands is successful, go to the [Terraform Cloud](https://app.terraform.io/app/organizations) and view the newly created resources:
1. A new **organization** with the default or specificed name.
2. a **project** containing:
    - One **VCS-driven workspace** linked with the GitHub repository (`AndotoN/Manage-TFC`).
    - Three **CLI-driven workspaces**.
3. Inside each CLI-driven workspace, check the **Variables** section to verify:
    - **Terraform variables**:
        - `organization_name`
        - `project_name`
    - **Environment variables**: (stored securely in write-only mode)
        - `GITHUB_TOKEN`
        - `TFE_TOKEN` 
