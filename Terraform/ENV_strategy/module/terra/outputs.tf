output "vpc_id" {
  value = module.vpc.child_vpc_id
}

output "public_subnet_id" {
  value = module.vpc.child_public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.child_private_subnet_id
}

output "vpc_region" {
  value = module.vpc.child_region
}


output "instance_id" {
  value = module.ec2.child_instance_id
}

output "public_ip" {
  value = module.ec2.child_public_ip
}

output "EC2_region" {
  value = module.ec2.child_region
}