root_vpc_cidr          = "10.0.0.0/16"
root_public_cidr       = ["10.0.2.0/24", "10.0.3.0/24"]
root_private_cidr      = "10.0.1.0/24"
root_availability_zone = ["us-east-1c", "us-east-1a"]

region = "us-east-1"

root_env = "dev"

root_ami           = "ami-0b6d9d3d33ba97d99"
root_instance_type = "t3.micro"
root_key_name      = "aws_key"