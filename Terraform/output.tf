output "Instance-name" {
  value = aws_instance.this.tags["Name"]
}

output "Public_IP" {
  value = aws_instance.this.public_ip
}

