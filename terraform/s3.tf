resource "aws_s3_bucket" "terraform_state" {
  bucket = "zoha-bucket-${var.environment}"

  tags = {
    Name = "zoha-terraform-state-bucket"
  }
}

# Allow public access by disabling the block public policy setting
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Define a public-read policy
resource "aws_s3_bucket_policy" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.terraform_state.arn}/*"
        Principal = "*"
      }
    ]
  })
}

terraform {
  backend "s3" {
    bucket         = "zoha-terraform-state-bucket-${var.environment}"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"  # Optional, for state locking
  }
}
