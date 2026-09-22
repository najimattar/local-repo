resource "aws_instance" "this" {

  ami           = var.ami_id
  instance_type = var.instance_type[local.machine]
  key_name      = "aws_key"

  tags = {
    Name = "Jenkins-${local.machine}"
  }
}