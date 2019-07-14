output "vpc_id" {
  value = "${aws_vpc.Assignment_TW.id}"
}

output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}

output "subnet1_id" {
  value = "${aws_subnet.public_subnet1.id}"
}

output "subnet2_id" {
  value = "${aws_subnet.public_subnet2.id}"
}

output "subnet3_id" {
  value = "${aws_subnet.public_subnet3.id}"
}
