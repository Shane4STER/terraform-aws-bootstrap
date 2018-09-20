resource "aws_vpc" "primary" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    ManagedByTerraform = "true"
  }
}

resource "aws_internet_gateway" "primary" {
  vpc_id = "${aws_vpc.primary.id}"

  tags {
    ManagedByTerraform = "true"
  }
}

resource "aws_key_pair" "bastion" {
  key_name_prefix = "bastion-key-"
  public_key      = "${var.ssh_public_key}"
}

module "dmz" {
  source = "modules/dmz"

  vpc_id = "${aws_vpc.primary.id}"
  igw_id = "${aws_internet_gateway.primary.id}"

  dmz_subnet_count = "${var.dmz_subnet_count}"
  dmz_cidr         = "${cidrsubnet(aws_vpc.primary.cidr_block, 1, 0)}"
}

module "lan" {
  source = "modules/lan"

  vpc_id = "${aws_vpc.primary.id}"
  igw_id = "${aws_internet_gateway.primary.id}"

  lan_subnet_count = "${var.lan_subnet_count}"
  lan_cidr         = "${cidrsubnet(aws_vpc.primary.cidr_block, 1, 1)}"

  nat_gateway_ids = "${module.dmz.nat_gateway_ids}"
}

module "bastion" {
  source = "modules/bastion"

  vpc_id      = "${aws_vpc.primary.id}"
  dmz_subnets = "${module.dmz.dmz_subnet_ids}"

  inbound_ssh_cidrs = ["${var.inbound_ssh_cidrs}"]
  ssh_key           = "${aws_key_pair.bastion.key_name}"
  bastion_ami_id    = "${var.bastion_ami_id}"
}
