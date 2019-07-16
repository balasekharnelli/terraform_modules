variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
  default = "10.0.2.0/24"
}

variable "public_subnet3_cidr" {
  default = "10.0.3.0/24"
}

variable "vpc_tag_name" {
  default = "Assignment_TW"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-035b3c7efe6d061d5"
}

variable "max_num_instances" {
  default = "5"
}

variable "min_num_instances" {
  default = "3"
}

variable "desired_capacity" {
  default = "3"
}

variable "max_threshold" {
  default = "80"
}

variable "min_threshold" {
  default = "30"
}

variable "cloudfront_origin_bucket" {
  default = "assignment-tw-origin"
}

variable "region" {
  default = "us-east-1"
}

variable "route53_primary_domain" {
  default = "www.bala.guru"
}
