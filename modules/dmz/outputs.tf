output "dmz_subnet_ids" {
  value = ["${aws_subnet.dmz.*.id}"]
}

output "nat_gateway_ids" {
  value = ["${aws_nat_gateway.ngw.*.id}"]
}
