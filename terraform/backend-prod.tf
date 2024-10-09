terraform {
  backend "s3" {
    bucket         = "zoha-terraform-state-bucket-prod"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
