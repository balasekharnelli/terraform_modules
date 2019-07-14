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
