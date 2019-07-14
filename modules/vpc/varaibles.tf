variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "192.168.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "CIDR for the public subnet"
  default     = "192.168.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "CIDR for the private subnet"
  default     = "192.168.2.0/24"
}

variable "public_subnet3_cidr" {
  description = "CIDR for the public subnet"
  default     = "192.168.3.0/24"
}

variable "vpc_id" {}

variable "igw_id" {}

variable "vpc_tag_name" {
  default = "TW_Assignment"
}

variable "public_subnet1_tag_name" {
  default = "Public Subnet 1"
}

variable "public_subnet2_tag_name" {
  default = "Public Subnet 2"
}

variable "public_subnet3_tag_name" {
  default = "Public Subnet 3"
}

variable "private_subnet1_tag_name" {
  default = "Private Subnet 1"
}
