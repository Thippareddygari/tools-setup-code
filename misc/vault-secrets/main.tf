terraform {
  backend "s3" {
    bucket = "remote-file-kishor"
    key = "vault-secret/state"
    region = "us-east-1"
  }
}

provider "vault" {
  address = "http://vault-internal.kommanuthala.store:8200"
  token = var.vault_token
}

variable "vault_token" {}

resource "vault_mount" "ssh" {
    path = "infra"
    type = "kv"
    options = {version= "2"}
    description = "Infra secrets"
}

resource "vault_generic_secret" "ssh" {
  path="${vault_mount.ssh.path}/ssh"

  data_json = <<EOT
  {
  "username": "ec2-user",
  "password": "DevOps321"
  }
  EOT
}

resource "vault_generic_secret" "github_runner" {
  path = "${vault_mount.ssh.path}/github-runner"

  data_json = <<EOT
  {
  
  }
  EOT
}