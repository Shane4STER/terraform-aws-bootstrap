# AWS Bootstrap

The new AWS Lab accounts from vending machines come out with nothing provisioned. Use this stack to provision a basic setup with public and private subnets, and a bastion ASG.

## Usage
```
module "lab-infra" {
  source = "git::ssh://git@bitbucket.org/cloudreach/cr-lab-bootstrap-aws.git"

  vpc_cidr = "10.0.0.0/16"
  ssh_public_key = "${var.ssh_public_key}"
  inbound_ssh_cidrs = "${var.inbound_ssh_cidrs}"
  dmz_subnet_count = -1
  lan_subnet_count = -1
}

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
