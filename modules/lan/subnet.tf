resource "aws_subnet" "lan" {
  count                   = "${var.lan_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.lan_subnet_count}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${cidrsubnet(var.lan_cidr, 3, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = false

  tags {
    ManagedByTerraform = "true"
  }
}

resource "aws_route_table" "lan" {
  count  = "${var.lan_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.lan_subnet_count}"
  vpc_id = "${var.vpc_id}"

  tags {
    ManagedByTerraform = "true"
  }
}

resource "aws_route" "nat_gateway" {
  count                  = "${var.lan_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.lan_subnet_count}"
  route_table_id         = "${element(aws_route_table.lan.*.id, count.index)}"
  nat_gateway_id         = "${element(var.nat_gateway_ids, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "lan" {
  count          = "${var.lan_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.lan_subnet_count}"
  subnet_id      = "${element(aws_subnet.lan.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.lan.*.id, count.index)}"
}
