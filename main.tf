data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2022-ami-*-x86_64"]

  }
}

data "template_file" "user_data" {
  template = file(var.user_data)
}

resource "aws_security_group" "tf_sg" {
  name   = var.sg_name
  vpc_id = var.vpc_id
  tags   = merge({ "Name" = var.sg_name }, var.sg_tags)
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

resource "aws_eip" "this" {
  vpc      = true
  instance = module.ec2_instance.id
}

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  name                        = var.name
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.tf_sg.id]
  user_data                   = data.template_file.user_data.rendered
  root_block_device           = var.root_block_device
}
