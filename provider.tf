provider "hcloud" {
  token = data.hcp_vault_secrets_app.techsecom-infra.secrets["hcloud_token"]
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}