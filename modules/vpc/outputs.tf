output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.main.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.allow_ssh.id
}
