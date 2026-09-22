
module "vpc" {
  source = "./modules/vpc"

  child_vpc_cidr          = var.root_vpc_cidr
  child_public_cidr       = var.root_public_cidr
  child_availability_zone = var.root_availability_zone
  child_private_cidr      = var.root_private_cidr
  child_env               = var.root_env
}


module "ec2" {
  source = "./modules/ec2"

  child_ami           = var.root_ami
  child_instance_type = var.root_instance_type
  child_key_name      = var.root_key_name
  child_env           = var.root_env
}