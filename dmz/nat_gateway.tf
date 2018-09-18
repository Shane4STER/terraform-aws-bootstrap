resource "aws_eip" "nat_ip" {
  count = "${var.dmz_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.dmz_subnet_count}"
  vpc   = true
}

resource "aws_nat_gateway" "ngw" {
  count         = "${var.dmz_subnet_count < 0 ? length(data.aws_availability_zones.available.names) : var.dmz_subnet_count}"
  allocation_id = "${element(aws_eip.nat_ip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.dmz.*.id, count.index)}"

  tags {
    ManagedByTerraform = "true"
  }
}
