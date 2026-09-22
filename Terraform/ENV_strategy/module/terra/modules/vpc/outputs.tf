output "child_vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "child_public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}


output "child_private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "child_region" {
  value = aws_vpc.my_vpc.region
}