variable "vpc_id" {
  type = "string"
}

variable "app_cidr" {
  type = "string"
}

variable "app_name" {
  type = "string"
}

variable "app_port" {
  type = "string"
}

variable "env" {
  type = "string"
}

variable "image_id" {
  type = "string"
}

variable "private1_subnet_id" {
  type = "string"
}

variable "private2_subnet_id" {
  type = "string"
}

variable "private3_subnet_id" {
  type = "string"
}

variable "sg_elb_id" {
  type = "string"
}

variable "elb_name" {
  type = "string"
}
