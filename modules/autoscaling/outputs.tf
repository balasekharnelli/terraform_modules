output "elb_dns_name" {
  value = "${aws_elb.Assignment_TW.dns_name}"
}

output "elb_name" {
  value = "${aws_elb.Assignment_TW.name}"
}
