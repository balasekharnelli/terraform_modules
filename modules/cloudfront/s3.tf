#Create S3 bucket
resource "aws_s3_bucket" "Assignment_TW_Origin" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[{
    "Sid":"PublicReadForGetBucketObjects",
      "Effect":"Allow",
      "Principal": "*",
      "Action":"s3:GetObject",
      "Resource":["arn:aws:s3:::${var.bucket_name}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_object" "object_png" {
  bucket = "${aws_s3_bucket.Assignment_TW_Origin.id}"
  key    = "logo.png"
  source = "${path.module}/s3_objects/logo.png"
}

resource "aws_s3_bucket_object" "object_css" {
  bucket = "${aws_s3_bucket.Assignment_TW_Origin.id}"
  key    = "company.css"
  source = "${path.module}/s3_objects/company.css"
}

resource "aws_s3_bucket_object" "companyNews_war" {
  bucket = "${aws_s3_bucket.Assignment_TW_Origin.id}"
  key    = "companyNews.war"
  source = "${path.module}/s3_objects/app_war/companyNews.war"
}
