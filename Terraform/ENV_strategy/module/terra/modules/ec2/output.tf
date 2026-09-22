output "child_instance_id" {
  value = aws_instance.web.id
}

output "child_public_ip" {
  value = aws_instance.web.public_ip
}

output "child_region" {
  value = aws_instance.web.region
}