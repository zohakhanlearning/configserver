# outputs.tf
output "eks_cluster_name" {
  value = aws_eks_cluster.my_cluster.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.configserver.repository_url
}

output "ec2_instance_id" {
  value = aws_instance.my_instance.id
}