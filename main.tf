# Configure the AWS provider to use LocalStack
provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
    s3  = "http://localhost:4566"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
}

module "iam" {
  source = "./modules/iam"

  role_name    = "example-role"
  profile_name = "example-profile"
}

module "ec2" {
  source = "./modules/ec2"

  ami_id               = "ami-df5de72bdb3b"
  instance_type        = var.instance_type
  subnet_id            = module.vpc.subnet_id
  security_group_ids   = [module.vpc.security_group_id]
  iam_instance_profile = module.iam.instance_profile_name
  user_data            = <<-EOF
                         #!/bin/bash
                         echo "Hello from the EC2 instance!"
                         EOF
}

module "s3" {
  source = "./modules/s3"

  bucket_name = "my-example-bucket-${random_id.bucket_suffix.hex}"
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}

# Outputs
output "instance_id" {
  value = module.ec2.instance_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

output "s3_bucket_name" {
  value = module.s3.bucket_id
}
