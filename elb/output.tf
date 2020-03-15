output "sg_elb_id" {
  value = "${aws_security_group.elb.id}"
}

output "elb_name" {
  value = "${aws_elb.main-elb.name}"
}
