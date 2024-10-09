resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "zoha-terraform-state-bucket-${var.environment}"

  tags = {
    Name = "Terraform State Bucket"
    Environment = var.environment
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"  # Auto scales the read/write throughput

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "dev"
  }
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption on the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Outputs for S3 bucket and DynamoDB table (optional)
output "state_bucket_name" {
  value = aws_s3_bucket.terraform_state_bucket.bucket
}

output "lock_table_name" {
  value = aws_dynamodb_table.terraform_lock_table.name
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

