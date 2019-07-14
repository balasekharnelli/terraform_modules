resource "aws_security_group" "elb_sg" {
  name   = "TW-Assignment-ELB-SG"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "TW_Assignment_elb_egress-out-1" {
  security_group_id = "${aws_security_group.elb_sg.id}"
  description       = "ELB In"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "TW_Assignment_elb_ingress-in-1" {
  security_group_id = "${aws_security_group.elb_sg.id}"
  description       = "ELB Out"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

#Instance Security Group
resource "aws_security_group" "instance_sg" {
  name   = "TW-Assignment-EC2-SG"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "TW_Assignment_instance_egress-out-1" {
  security_group_id = "${aws_security_group.instance_sg.id}"
  description       = "EC2 out"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "TW_Assignment_instance_ingress-in-1" {
  security_group_id        = "${aws_security_group.instance_sg.id}"
  description              = "EC2 in"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb_sg.id}"
}

resource "aws_security_group_rule" "TW_Assignment_instance_ingress-in-2" {
  security_group_id = "${aws_security_group.instance_sg.id}"
  description       = "EC2 SSH in"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
