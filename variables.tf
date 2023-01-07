variable "aws_profile" {
  description = "AWS CLI profile which terrafrom will use to create all the resources"
  type        = string
  default     = "eu-west-2"
}

variable "aws_region" {
  description = "Default region in AWS where terrafrom will create all the resources"
  type        = string
  default     = "eu-west-2"
}

variable "user_data" {
    description = "The user data needs to be passed into the instance during launch"
    type = string
    default = ""
}

variable "ami" {
    description = "The AMI to be used to create the instance"
    type = string
    default = ""
}

variable "instance_type" {
    description = "The type of the instance to be used"
    type = string
    default = ""
}

variable "subnet_id" {
    description = "The subnet in which the instance needs to be created"
    type = string
    default = ""
}

variable "key_name" {
    description = "The key to be used to connect to the instance"
    type = string
    default = ""
}

variable "user_data" {
    description = "The user data needs to be passed into the instance during launch"
    type = string
    default = ""
}

variable "root_block_device" {
    description = "The root block device for the instance"
    type = list(map(string))
    default  =[]
}

variable "ebs_block_device" {
    description = "The list of ebs volumes for the instance"
    type = list(map(string))
    default = []
}

variable "volume_tags" {
    description = "The tags for the volumes in the instance"
    type = map
    default = {}
}

variable "tags" {
    description = "The map of tags for the instance"
    type = map
    default = {}
}

variable "sg_name" {
    description = "The name of the security group"
    type = string
    default = ""
}

variable "sg_rules" {
    description = "The list of security group ingress rules"
    type = list
    default = []
}

variable "vpc_id" {
    description = "The VPC your app belongs to"
    type = string
    default = ""
}

variable "sg_tags" {
    description = "The tags for the security group"
    type = map
    default = {}
}

variable "name" {
    description = "The tags for the security group"
    type = string
    default = "demo"
}

variable "environment" {
    description = "The tags for the security group"
    type = string
    default = "dev"
}
