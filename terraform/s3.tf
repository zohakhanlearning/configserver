# Declare the S3 bucket
resource "aws_s3_bucket" "S3-bucket" {
  bucket = "zoha-bucket-dev"

  tags = {
    Name = "S3 bucket"
    Environment = var.environment
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "S3-bucket" {
  bucket = aws_s3_bucket.S3-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption (SSE) for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "S3-bucket" {
  bucket = aws_s3_bucket.S3-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}



# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "S3-bucket" {
  bucket = aws_s3_bucket.S3-bucket.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}



# S3 bucket policy to restrict access to specific IAM roles
resource "aws_s3_bucket_policy" "S3-bucket" {
  bucket = aws_s3_bucket.S3-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = "${aws_s3_bucket.S3-bucket.arn}/*"
        Principal = {
          AWS = "arn:aws:iam::557690605107:user/terraform-gh-actions"
        }
      }
    ]
  })
}
