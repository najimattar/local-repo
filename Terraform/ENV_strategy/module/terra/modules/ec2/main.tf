
resource "aws_instance" "web" {

  ami = var.child_ami

  instance_type = var.child_instance_type

  key_name = var.child_key_name

  tags = {
    Name = "${var.child_env} - webserver"
  }

}