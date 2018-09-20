variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR range to provision the VPC with. Defaults to 10.0.0.0/16. Must be a valid CIDR for an AWS VPC. ie /16 - /28"
}

variable "ssh_public_key" {
  description = "SSH Key for bastion access"
}

variable "inbound_ssh_cidrs" {
  description = "A list of CIDRs that are able to SSH to the bastion host."
  type        = "list"
}

variable "bastion_ami_id" {
  description = "AMI ID to use for the bastion host"
}

variable "dmz_subnet_count" {
  default     = -1
  description = "The number of DMZ (public) subnets to be created. Use -1 to create as many subnets as AZs. Default -1."
}

variable "lan_subnet_count" {
  default     = -1
  description = "The number of LAN (private) subnets to be created. Use -1 to create as many subnets as AZs. Default -1."
}
