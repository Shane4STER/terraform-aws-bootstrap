# AWS Bootstrap

The new AWS Lab accounts from vending machines come out with nothing provisioned. Use this stack to provision a basic setup with public and private subnets, and a bastion ASG.

## Requirements

* Terraform version listed in `.terraform-version` or [tfenv](https://github.com/Zordrak/tfenv)
* An infrastructure deployer role with admin privileges

## Usage
```
$ terraform init
$ terraform plan
$ terraform apply
```
|Name|Description|Type|Default|Required|
|:--:|-----------|:--:|:-----:|:------:|
| vpc_cidr | CIDR Range to provision the VPC with. | `String` | `10.0.0.0/16` | no |
| ssh_public_key | SSH Key for bastion access. `authourized_keys` format. | `String` | `` | yes |
| inbound_ssh_cidrs | List of CIDRs allowed to access bastion host. | `List` | `` | no |
| dmz_subnet_count | Number of DMZ subnets to create. Use `-1` to create 1 subnet per AZ | `Number` | `-1` | no|
| lan_subnet_count | Number of LAN subnets to create. Use `-1` to create 1 subnet per AZ | `Number` | `-1` | no|


## Contributing
Feel free to contribute by forking and submitting as a pull request.

## TODO
* DNS with Route53
* Tests?
* Fix SSH host key on bastion replacement.
