output "cf_domain_name" {
  value = "${aws_cloudfront_distribution.Assignment_TW.domain_name}"
}

output "cf_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.Assignment_TW.hosted_zone_id}"
}
