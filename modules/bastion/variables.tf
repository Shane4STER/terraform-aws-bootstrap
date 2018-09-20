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

variable "bastion_ami_id" {
  description = "AMI ID to use for the bastion host"
}
