output "child_vpc_id" {
  value = aws_vpc.child_vpc.id
}

output "child_public_subnet_id" {
  value = aws_subnet.child_public_subnet[*].id
}

output "child_private_subnet_id" {
  value = aws_subnet.child_private_subnet[*].id
}

output "child_internet_gateway_id" {
  value = aws_internet_gateway.child_igw.id
}

output "child_nat_gateway_id" {
  value = aws_nat_gateway.child_nat[*].id
}
