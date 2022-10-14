provider "github" {
  owner = "coremaker"

  # Authentication using user token
  token = "---GITHUB_USER_TOKEN---"

  # Authentication using app_auth
  app_auth { 
    id              = "---GITHUB_APP_ID---"
    installation_id = "---GITHUB_APP_INSTALLATION_ID---"
    pem_file        = "---GITHUB_APP_PEM_FILE---"
  }
}