variable "elb_name" {
  default = "TW-Assignment-ELB"
}

variable "vpc_id" {}
variable "subnet1_id" {}
variable "subnet2_id" {}
variable "subnet3_id" {}

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
  default = "4"
}

variable "max_threshold" {
  default = "80"
}

variable "min_threshold" {
  default = "30"
}
