data "template_file" "user_data" {
  template = file(var.user_data)
}

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 3.0"
  name                        = var.name
  ami                         = var.ami
  tenancy                     = "default"
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = "false"
  key_name                    = var.key_name
  monitoring                  = "true"
  vpc_security_group_ids      = [aws_security_group.tf_sg.id]
  user_data                   = data.template_file.user_data.rendered
  iam_instance_profile        = aws_iam_instance_profile.profile.id
  root_block_device           = var.root_block_device
  ebs_block_device            = var.ebs_block_device
  volume_tags                 = var.volume_tags
  tags                        = var.tags
}

resource "aws_security_group" "tf_sg" {
    name        = var.sg_name
    vpc_id      = var.vpc_id
    tags        = merge({"Name" = var.sg_name}, var.sg_tags)
}

resource "aws_security_group_rule" "tf_sg_ingress_rule" {
    count             = length(var.sg_rules)
    security_group_id = aws_security_group.tf_sg.id
    type              = lookup(var.sg_rules[count.index], "type")
    description       = lookup(var.sg_rules[count.index], "description")
    from_port         = lookup(var.sg_rules[count.index], "from_port")
    to_port           = lookup(var.sg_rules[count.index], "to_port")
    protocol          = lookup(var.sg_rules[count.index], "protocol")
    cidr_blocks       = lookup(var.sg_rules[count.index], "cidr_blocks")
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.name}-${var.environment}-iam-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "test_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
