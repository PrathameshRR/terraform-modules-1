resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.instance_name
  }

  iam_instance_profile = var.iam_instance_profile

  user_data = var.user_data
}
