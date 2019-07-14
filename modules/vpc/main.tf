#Create VPC

resource "aws_vpc" "Assignment_TW" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc_tag_name}"
  }
}

data "aws_availability_zones" "available" {}

#Create Public Subnets

resource "aws_subnet" "public_subnet1" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnet1_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "${var.public_subnet1_tag_name}"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnet2_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "${var.public_subnet2_tag_name}"
  }
}

resource "aws_subnet" "public_subnet3" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnet3_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"

  tags {
    Name = "${var.public_subnet2_tag_name}"
  }
}

#Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "VPC IGW"
  }
}

#Route Table
resource "aws_route_table" "public_RT" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igw_id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}

#Assign Route Table to the Public Subnet 1
resource "aws_route_table_association" "public-RT-1" {
  subnet_id      = "${aws_subnet.public_subnet1.id}"
  route_table_id = "${aws_route_table.public_RT.id}"
}

#Assign Route Table to the Public Subnet 2
resource "aws_route_table_association" "public-RT-2" {
  subnet_id      = "${aws_subnet.public_subnet2.id}"
  route_table_id = "${aws_route_table.public_RT.id}"
}

#Assign Route Table to the Public Subnet 2
resource "aws_route_table_association" "public-RT-3" {
  subnet_id      = "${aws_subnet.public_subnet3.id}"
  route_table_id = "${aws_route_table.public_RT.id}"
}
