module "vpc" {
  source                  = "./modules/vpc/"
  child_vpc_cidr          = var.root_vpc_cidr
  child_public_cidr       = var.root_public_cidr
  child_private_cidr      = var.root_private_cidr
  child_availability_zone = var.root_availability_zone
  child_env               = var.root_env
}