resource "aws_instance" "web"{

	ami = var.ami_id
	instance_type= var.instance_type

	key_name = "aws_key"

	tags = {
		Name = var.name
		Environment= var.env
	}
}