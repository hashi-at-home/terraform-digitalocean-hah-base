terraform {
  required_version = ">= 1.1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.58.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "5.1.0"
    }
  }

  backend "consul" {
    path = "do/hah-vpc"
  }
}

variable "region" {
  type        = string
  description = "DO Region to deploy into"
  default     = "ams3"
}
variable "ssh_key_name" {
  type        = string
  description = "SSH Key for digital ocean droplets"
  default     = "test-instances"
}



data "vault_generic_secret" "do_token" {
  path = "digitalocean/tokens"
}

data "vault_generic_secret" "ssh" {
  path = "digitalocean/ssh_key"
}

data "http" "personal_ssh_key" {
  url = "https://api.github.com/users/brucellino/keys"
}
provider "digitalocean" {
  token             = data.vault_generic_secret.do_token.data["terraform"]
  spaces_access_id  = data.vault_generic_secret.do_token.data["spaces_key"]
  spaces_secret_key = data.vault_generic_secret.do_token.data["spaces_secret"]
}

# Digital Ocean VPC for droplets
resource "digitalocean_vpc" "vpc" {
  name        = "terraform-vpc-hah"
  region      = var.region
  description = "VPC for hashi at home"
  ip_range    = "10.10.10.0/24"
}

resource "digitalocean_spaces_bucket" "images" {
  name   = "hah-images"
  region = var.region
  acl    = "private"
  versioning {
    enabled = true
  }
}
resource "digitalocean_ssh_key" "test_instance" {
  name       = var.ssh_key_name
  public_key = data.vault_generic_secret.ssh.data["public_key"]
}

resource "digitalocean_ssh_key" "personal" {
  name       = "personal"
  public_key = jsondecode(data.http.personal_ssh_key.body)[0].key
}
