resource "aws_instance" "this" {

  ami           = var.ami_id
  instance_type = var.instance_type[local.machine]
  key_name      = "aws_key"

  tags = {
    Name = "Jenkins-${local.machine}"
  }

  vpc_security_group_ids = var.security_group[local.machine]

}