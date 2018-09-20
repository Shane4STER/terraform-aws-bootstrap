output "bastion_dns" {
  value = "${aws_lb.bastion.dns_name}"
}

output "bastion_sg" {
  value = "${aws_security_group.bastion_access.id}"
}
