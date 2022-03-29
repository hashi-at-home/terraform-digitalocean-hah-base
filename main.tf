terraform {
  required_version = ">= 1.1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.4.0"
    }
  }

  backend "consul" {
    path = "do/hah-vpc-with-space"
  }
}

variable "ssh_key_name" {
  type        = string
  description = "SSH Key for digital ocean droplets"
  default     = "test-instances"
}

data "vault_generic_secret" "do_token" {
  path = "kv/do"
}

data "vault_generic_secret" "ssh" {
  path = "digitalocean/ssh_key"
}

provider "digitalocean" {
  token             = data.vault_generic_secret.do_token.data["token"]
  spaces_access_id  = data.vault_generic_secret.do_token.data["access_key_hashi_at_home"]
  spaces_secret_key = data.vault_generic_secret.do_token.data["secret_key_hashi_at_home"]
}

module "test-space" {
  selected_region = "🇳🇱"
  bucket_name     = "terraform-backend-hah"
  source          = "github.com/hashi-at-home/tfmod-do-space"
}

# Digital Ocean VPC for droplets
resource "digitalocean_vpc" "vpc" {
  name        = "terraform-vpc-hah"
  region      = "ams3"
  description = "VPC for hashi at home"
  ip_range    = "10.10.10.0/24"
}

resource "digitalocean_ssh_key" "test_instance" {
  name       = var.ssh_key_name
  public_key = data.vault_generic_secret.ssh.data["public_key"]
}
