output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.example.private_ip
}
