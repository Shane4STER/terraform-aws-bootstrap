output "bastion_cname" {
  description = "CNAME of the bastion LB. NB: after connecting once, you will get a fingerprint error if the bastion has been replaced."
  value       = "${module.bastion.bastion_dns}"
}

output "bastion_sg" {
  description = "Security group allowing the bastion host SSH access"
  value       = "${module.bastion.bastion_sg}"
}

output "dmz_subnets_ids" {
  description = "List of DMZ (public) subnet ids"
  value       = "${module.dmz.dmz_subnet_ids}"
}

output "lan_subnets_ids" {
  description = "List of LAN (private) subnet ids"
  value       = "${module.lan.lan_subnet_ids}"
}
