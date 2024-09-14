# ecr.tf
resource "aws_ecr_repository" "my_app" {
  name = "my-app"

  lifecycle {
    prevent_destroy = true
  }
}
