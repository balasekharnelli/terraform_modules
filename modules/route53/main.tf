resource "aws_route53_zone" "primary" {
  name = "${var.route53_primary_domain}"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "${var.route53_primary_domain}"
  type    = "A"

  alias {
    name                   = "${var.cf_domain_name}"
    zone_id                = "${var.cf_hosted_zone_id}"
    evaluate_target_health = true
  }
}

#Domain Registration

