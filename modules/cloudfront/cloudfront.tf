resource "aws_cloudfront_origin_access_identity" "Assignment_TW" {
  comment = "${var.cf_name}-cf"
}

# Create Cloudfront distribution
resource "aws_cloudfront_distribution" "Assignment_TW" {
  comment          = "${var.cf_name}"
  enabled          = true
  price_class      = "PriceClass_100"
  retain_on_delete = true

  #S3 origin
  origin {
    domain_name = "${aws_s3_bucket.Assignment_TW_Origin.bucket}.s3.amazonaws.com"
    origin_id   = "S3-${aws_s3_bucket.Assignment_TW_Origin.bucket}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.Assignment_TW.cloudfront_access_identity_path}"
    }
  }

  #ELB origin
  origin {
    domain_name = "${var.elb_dns_name}"
    origin_id   = "ELB-${var.elb_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2", "SSLv3"]
    }
  }

  # By default, show index.html file
  default_root_object = "index.jsp"

  # If there is a 404, return index.html with a HTTP 200 Response
  custom_error_response {
    error_caching_min_ttl = 3000
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.jsp"
  }

  #Default Behaviour served by S3
  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${aws_s3_bucket.Assignment_TW_Origin.bucket}"
    viewer_protocol_policy = "redirect-to-https"

    "forwarded_values" {
      "cookies" {
        forward = "none"
      }

      query_string = false
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  #Ordered Cache Behaviour with Precedence 1
  ordered_cache_behavior {
    path_pattern           = "/"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "ELB-${var.elb_name}"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
