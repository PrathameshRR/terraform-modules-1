# Terraform LocalStack Infrastructure

This Terraform configuration creates a simple infrastructure on LocalStack, simulating AWS services.


.
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
└── modules
├── vpc
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── iam
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── ec2
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
└── s3
├── main.tf
├── variables.tf
└── outputs.tf



## Modules

### VPC Module
- Creates a VPC with a subnet and a security group allowing SSH access.
- Files:
  - `modules/vpc/main.tf`: Defines the VPC, subnet, and security group resources.
  - `modules/vpc/variables.tf`: Declares input variables for VPC CIDR, subnet CIDR, availability zone, and resource names.
  - `modules/vpc/outputs.tf`: Exposes VPC ID, subnet ID, and security group ID.

### IAM Module
- Creates an IAM role and instance profile for EC2 instances.
- Files:
  - `modules/iam/main.tf`: Defines the IAM role and instance profile resources.
  - `modules/iam/variables.tf`: Declares input variables for role and profile names.
  - `modules/iam/outputs.tf`: Exposes the role name and instance profile name.

### EC2 Module
- Launches an EC2 instance in the created VPC with the specified IAM role.
- Files:
  - `modules/ec2/main.tf`: Defines the EC2 instance resource.
  - `modules/ec2/variables.tf`: Declares input variables for AMI ID, instance type, subnet ID, security group IDs, instance name, IAM instance profile, and user data.
  - `modules/ec2/outputs.tf`: Exposes the instance ID and private IP.

### S3 Module
- Creates an S3 bucket with a specified name.
- Files:
  - `modules/s3/main.tf`: Defines the S3 bucket resource.
  - `modules/s3/variables.tf`: Declares an input variable for the bucket name.
  - `modules/s3/outputs.tf`: Exposes the bucket ID and ARN.

## Main Configuration

The `main.tf` file in the root directory orchestrates the creation of resources using the defined modules. It includes:

- AWS provider configuration for LocalStack
- Data source for available availability zones
- Module calls for VPC, IAM, EC2, and S3
- Random ID resource for unique S3 bucket naming

## Variables

The `variables.tf` file in the root directory defines input variables:

- `vpc_cidr`: CIDR block for the VPC (default: "10.0.0.0/16")
- `subnet_cidr`: CIDR block for the subnet (default: "10.0.1.0/24")
- `instance_type`: EC2 instance type (default: "t2.micro")

## Outputs

The main configuration outputs:

- `instance_id`: ID of the created EC2 instance
- `vpc_id`: ID of the created VPC
- `subnet_id`: ID of the created subnet
- `s3_bucket_name`: Name of the created S3 bucket

## Usage

1. Ensure LocalStack is running.
2. Initialize Terraform:
   ```
   terraform init
   ```
3. Plan the changes:
   ```
   terraform plan
   ```
4. Apply the changes:
   ```
   terraform apply
   ```

## Note

This configuration is designed to work with LocalStack and simulates AWS services locally. It's not intended for use with actual AWS resources without modifications.

## Customization

You can customize the deployment by modifying the variables in `variables.tf` or by passing variable values at runtime:

terraform apply -var="vpc_cidr=172.16.0.0/16" -var="instance_type=t3.micro"


## Cleanup

To remove all created resources:
    ```
terraform destroy
```

