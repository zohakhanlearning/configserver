# ecr.tf
resource "aws_ecr_repository" "configserver" {
  name = "configserver"

  lifecycle {
    prevent_destroy = false
  }
}
