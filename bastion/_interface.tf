variable "vpc_id" {
  description = "VPC bastion is to be deployed in"
}

variable "dmz_subnets" {
  type        = "list"
  description = "A list of dmz subnets for the bastion ASG"
}

variable "inbound_ssh_cidrs" {
  type        = "list"
  description = "A list of CIDRs allowed to access the bastion via SSH"
}

variable "ssh_key" {
  description = "SSH Key name for bastion access"
}

data "aws_ami" "bastion" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"] # Amazon
}

output "bastion_dns" {
  value = "${aws_lb.bastion.dns_name}"
}

output "bastion_sg" {
  value = "${aws_security_group.bastion_access.id}"
}
