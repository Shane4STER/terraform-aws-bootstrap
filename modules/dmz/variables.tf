variable "vpc_id" {
  description = "The ID of the vpc subnets are to be created in"
}

variable "igw_id" {
  description = "The ID of the internet gateway"
}

variable "dmz_subnet_count" {
  default     = -1
  description = "The number of DMZ (public) subnets to be created. Use -1 to create as many subnets as AZs. Default -1"
}

variable "dmz_cidr" {
  default     = "10.0.0.0/17"
  description = "The subnet that contains ALL DMZ subnets, should be calculated off VPC CIDR."
}

variable "dmz_ipv6_cidr" {
  description = "The IPv6 subnet for whole DMZ. At most this can be a /60"
}
