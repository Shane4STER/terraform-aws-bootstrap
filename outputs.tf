output "bastion_cname" {
  description = "CNAME of the bastion LB. NB: after connecting once, you will get a fingerprint error if the bastion has been replaced."
  value = "${module.bastion.bastion_dns}"
}
