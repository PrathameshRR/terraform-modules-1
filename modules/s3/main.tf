resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  
  tags = {
    Name = var.bucket_name
  }
}
