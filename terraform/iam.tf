resource "aws_iam_policy" "s3_policy_permissions" {
  name        = "S3PolicyPermissions"
  description = "Policy to allow managing bucket policies for the Terraform state bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:ListBucket",
          "s3:PutBucketPolicy",
          "s3:GetBucketPolicy",
          "s3:DeleteBucketPolicy"
        ],
        "Resource" = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "terraform_user_policy_attach" {
  user       = "terraform-gh-actions"
  policy_arn = aws_iam_policy.s3_policy_permissions.arn
}

