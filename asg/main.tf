#ASG_SG
resource "aws_security_group" "asg" {
  name = "${var.app_name}-${var.env}-asg-sg"
  description = "asg"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "asg-ingress" {
  type = "ingress"
  from_port = "${var.app_port}"
  to_port = "${var.app_port}"
  protocol = "tcp"
  source_security_group_id = "${var.sg_elb_id}"
  security_group_id = aws_security_group.asg.id
}

resource "aws_security_group_rule" "asg-egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg.id
}


#ASG
resource "aws_launch_configuration" "as_conf" {
  image_id = "${var.image_id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.asg.id}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main-asg" {
  name = "${var.app_name}-${var.env}-asg"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  min_size = 1
  max_size = 3
  load_balancers = ["${var.elb_name}"]
  health_check_type = "ELB"
  vpc_zone_identifier = ["${var.private1_subnet_id}","${var.private2_subnet_id}","${var.private3_subnet_id}"]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "${var.app_name}-${var.env}-app"
    propagate_at_launch = true
  }
}
