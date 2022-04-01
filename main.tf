terraform {
  required_version = ">= 1.1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "= 2.19.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "= 3.4.0"
    }
  }

  backend "consul" {
    path = "do/hah-vpc"
  }
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

provider "digitalocean" {
  token = data.vault_generic_secret.do_token.data["terraform"]
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
