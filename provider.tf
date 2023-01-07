terraform {
  required_version = ">= 0.11.11"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
