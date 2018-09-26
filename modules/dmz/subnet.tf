resource "aws_subnet" "dmz" {
  count                   = "${var.dmz_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.dmz_subnet_count}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${cidrsubnet(var.dmz_cidr, 3, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = true

  tags {
    ManagedByTerraform = "true"
  }
}

resource "aws_route_table" "dmz" {
  vpc_id = "${var.vpc_id}"

  tags {
    ManagedByTerraform = "true"
  }
}

resource "aws_route" "internet" {
  route_table_id         = "${aws_route_table.dmz.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.igw_id}"
}

resource "aws_route_table_association" "dmz" {
  count          = "${var.dmz_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.dmz_subnet_count}"
  subnet_id      = "${element(aws_subnet.dmz.*.id, count.index)}"
  route_table_id = "${aws_route_table.dmz.id}"
}
