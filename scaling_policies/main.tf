#AS_POLICIES
resource "aws_autoscaling_policy" "scaleup-asp" {
  name = "${var.app_name}-${var.env}-scaleup-asp"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_autoscaling_policy" "scaledown-asp" {
  name = "${var.app_name}-${var.env}-scaledown-asp"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${var.asg_name}"
}

#CLOUDWATCH
resource "aws_cloudwatch_metric_alarm" "scaleup-cloudwatch" {
  alarm_name = "${var.app_name}-${var.env}-scaleup-cloudwatch_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "2"
  dimensions = {
    AutoScalingGroupName = "${var.asg_name}"
  }
  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions = ["${aws_autoscaling_policy.scaleup-asp.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "scaledown-cloudwatch" {
  alarm_name = "${var.app_name}-${var.env}-scaledown-cloudwatch_alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "1"
  dimensions = {
    AutoScalingGroupName = "${var.asg_name}"
  }
  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions = ["${aws_autoscaling_policy.scaledown-asp.arn}"]
}
