# eks.tf
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn  = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.public[0].id,
      aws_subnet.public[1].id
    ]
  }

  tags = {
    Name = "my-cluster"
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role     = aws_iam_role.eks_cluster.name
}
