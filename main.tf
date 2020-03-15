#S3
terraform{
  backend "s3"{

  }
}

#PROVIDER
provider "aws" {
  region  = "${var.app_region}"
}

#ELB
module "elb" {
  source = "./elb"

  vpc_id             = "${var.vpc_id}"
  app_cidr           = "${var.app_cidr}"
  app_name           = "${var.app_name}"
  app_port           = "${var.app_port}"
  env                = "${var.env}"
  public1_subnet_id  = "${var.public1_subnet_id}"
  public2_subnet_id  = "${var.public2_subnet_id}"
  public3_subnet_id  = "${var.public3_subnet_id}"
}

#ASG
module "asg" {
  source = "./asg"

  vpc_id             = "${var.vpc_id}"
  app_cidr           = "${var.app_cidr}"
  app_name           = "${var.app_name}"
  app_port           = "${var.app_port}"
  env                = "${var.env}"
  image_id           = "${var.image_id}"
  private1_subnet_id = "${var.private1_subnet_id}"
  private2_subnet_id = "${var.private2_subnet_id}"
  private3_subnet_id = "${var.private3_subnet_id}"
  sg_elb_id          = "${module.elb.sg_elb_id}"
  elb_name           = "${module.elb.elb_name}"
}

#SCALING POLICIES
module "scaling_policies" {
  source = "./scaling_policies"
  
  app_name           = "${var.app_name}"
  env                = "${var.env}"
  private1_subnet_id = "${var.private1_subnet_id}"
  private2_subnet_id = "${var.private2_subnet_id}"
  private3_subnet_id = "${var.private3_subnet_id}"
  asg_name           = "${module.asg.asg_name}"
}
