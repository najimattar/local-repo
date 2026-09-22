output "root_vpc_id" {
  value = module.vpc.child_vpc_id
}

output "root_public_subnet_id" {
  value = module.vpc.child_public_subnet_id
}

output "root_private_subnet_id" {
  value = module.vpc.child_private_subnet_id
}

output "root_internet_gateway_id" {
  value = module.vpc.child_internet_gateway_id
}

output "root_nat_gateway_id" {
  value = module.vpc.child_nat_gateway_id
}