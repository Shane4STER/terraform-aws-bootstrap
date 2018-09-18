# AWS Bootstrap

The new AWS Lab accounts from vending machines come out with nothing provisioned. Use this stack to provision a basic setup with public and private subnets, and a bastion ASG.

## Requirements

* Terraform version listed in `.terraform-version` or [tfenv](https://github.com/Zordrak/tfenv)
* An infrastructure deployer role with admin privledges

## Usage
```
$ terraform init
$ terraform plan
$ terraform apply
```

## Contributing
Feel free to contribute by forking and submitting as a pull request.

## TODO
* Properly Assume lab role
* DNS with Route53
* Tests?
* Serve as a module to be included in other projects
