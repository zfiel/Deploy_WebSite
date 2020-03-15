#ELB_SG
resource "aws_security_group" "elb" {
  name = "${var.app_name}-${var.env}-elb-sg"
  description = "elb"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "elb-ingress" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "elb-egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

#ELB
resource "aws_elb" "main-elb" {
  name = "${var.app_name}-${var.env}-elb"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets = ["${var.public1_subnet_id}","${var.public2_subnet_id}","${var.public3_subnet_id}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    target = "HTTP:${var.app_port}/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.app_port}"
    instance_protocol = "http"
  }
}
