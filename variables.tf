//
// Variables
//

variable "env" {
  type = string
  description = "This is the environment : dev, prod or preprod."
}

variable "app_name" {
  type = string
  description = "This is the application name."
}

variable "app_cidr" {
  type = string
  description = "This is the infrastructure cidr : it depends on the environment."
}

variable "app_region" {
  type = string
  description = "This is the AWS region in which the infrastructure will be deployed."
}

variable "app_port" {
  type = string
  description = "This is the listening port of the website."
}

variable "vpc_id" {
  type = string
}

variable "public1_subnet_id" {
  type = string
}

variable "public2_subnet_id" {
  type = string
}

variable "public3_subnet_id" {
  type = string
}

variable "private1_subnet_id" {
  type = string
}

variable "private2_subnet_id" {
  type = string
}

variable "private3_subnet_id" {
  type = string
}

variable "image_id" {
  type = string
  description = "This is the AMI id of the website image (created by Packer)."
}
