## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | = 2.19.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | = 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.19.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_spaces_bucket.images](https://registry.terraform.io/providers/digitalocean/digitalocean/2.19.0/docs/resources/spaces_bucket) | resource |
| [digitalocean_ssh_key.test_instance](https://registry.terraform.io/providers/digitalocean/digitalocean/2.19.0/docs/resources/ssh_key) | resource |
| [digitalocean_vpc.vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/2.19.0/docs/resources/vpc) | resource |
| [vault_generic_secret.do_token](https://registry.terraform.io/providers/hashicorp/vault/3.4.0/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.ssh](https://registry.terraform.io/providers/hashicorp/vault/3.4.0/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | DO Region to deploy into | `string` | `"ams3"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | SSH Key for digital ocean droplets | `string` | `"test-instances"` | no |

## Outputs

No outputs.
