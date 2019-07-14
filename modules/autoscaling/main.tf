resource "aws_key_pair" "Assignment_TW" {
  key_name   = "Assignment_TW"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCggwvvYTzRq07j0basYq6fDE4Kowl/bQxa2ZOA+NqmjfOc6OEi6yvWYcLejGs0OtxacwgCC9hOX7+Zn6hXxfsi/+ay/mECv7WbMkk6LEubDmpgct9wTCPT7N+7EwVthbk5NnfmFUQ8sE9zJOrHXeYnlIcGOOKhplBWAsRX5b+QJQ=="
}

##Launch configuration
resource "aws_launch_configuration" "Assignment_TW" {
  name_prefix     = "Assignment_TW_Webserver-"
  image_id        = "${var.ami_id}"
  instance_type   = "${var.ec2_instance_type}"
  security_groups = ["${aws_security_group.instance_sg.id}"]
  key_name        = "${aws_key_pair.Assignment_TW.key_name}"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 80 &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

##Autoscaling Group
resource "aws_autoscaling_group" "Assignment_TW" {
  name                      = "Assignment_TW"
  max_size                  = "${var.max_num_instances}"
  min_size                  = "${var.min_num_instances}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.Assignment_TW.name}"
  vpc_zone_identifier       = ["${var.subnet1_id}", "${var.subnet2_id}", "${var.subnet3_id}"]
  load_balancers            = ["${aws_elb.Assignment_TW.id}"]

  tag {
    key                 = "Name"
    value               = "Assignment_TW"
    propagate_at_launch = true
  }
}

#Autoscaling Policy
resource "aws_autoscaling_policy" "Assignment_TW_Up" {
  name                   = "Assignment_TW_Up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.Assignment_TW.name}"
}

resource "aws_cloudwatch_metric_alarm" "Assignment_TW_Up" {
  alarm_name          = "Assignment_TW_Up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "${var.max_threshold}"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.Assignment_TW.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.Assignment_TW_Up.arn}"]
}

#Autoscaling Down Policy
resource "aws_autoscaling_policy" "Assignment_TW_Down" {
  name                   = "Assignment_TW_Down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.Assignment_TW.name}"
}

resource "aws_cloudwatch_metric_alarm" "Assignment_TW_Down" {
  alarm_name          = "Assignment_TW_Down"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "${var.min_threshold}"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.Assignment_TW.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.Assignment_TW_Down.arn}"]
}
