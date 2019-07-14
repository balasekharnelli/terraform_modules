data "aws_availability_zones" "all" {}

### Creating ELB
resource "aws_elb" "Assignment_TW" {
  name                        = "${var.elb_name}"
  security_groups             = ["${aws_security_group.elb_sg.id}"]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 300
  idle_timeout                = 60
  subnets                     = ["${var.subnet1_id}", "${var.subnet2_id}", "${var.subnet3_id}"]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }

  tags {
    Name = "${var.elb_name}-elb"
  }
}
