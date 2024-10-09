variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "environment" {
  description = "The environment to deploy (dev, prod)"
  type        = string
  default     = "dev"
}