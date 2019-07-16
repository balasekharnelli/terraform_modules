output "ns-servers" {
  value = "${aws_route53_zone.primary.name_servers}"
}
