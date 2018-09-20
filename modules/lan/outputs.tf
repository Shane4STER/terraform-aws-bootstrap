output "lan_subnet_ids" {
  value = ["${aws_subnet.lan.*.id}"]
}
