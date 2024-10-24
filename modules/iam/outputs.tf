output "role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.example_role.name
}

output "instance_profile_name" {
  description = "The name of the IAM instance profile"
  value       = aws_iam_instance_profile.example_profile.name
}
