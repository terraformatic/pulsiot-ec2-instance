terraform {
  required_version = ">= 0.11.11"
}

provider "aws" {
  region = var.aws_region
}
