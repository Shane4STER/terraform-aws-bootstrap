variable "vpc_id" {
  description = "The ID of the vpc subnets are to be created in"
}

variable "igw_id" {
  description = "The ID of the internet gateway"
}

variable "lan_subnet_count" {
  default     = -1
  description = "The number of LAN (private) subnets to be created. Use -1 to create as many subnets as AZs. Default -1"
}

variable "nat_gateway_ids" {
  type        = "list"
  description = "A list of NAT gateway IDs to be used for LAN instances contacting the internet"
}

variable "lan_cidr" {
  default     = "10.0.0.0/17"
  description = "The subnet that contains ALL LAN subnets, should be calculated off VPC CIDR."
}
