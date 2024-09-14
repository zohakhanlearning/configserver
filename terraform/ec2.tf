# ec2.tf
resource "aws_instance" "my_instance" {
  ami           = "ami-0688ba7eeeeefe3cd" # Example AMI ID, choose one appropriate for your region and needs
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id
  associate_public_ip_address = true

  tags = {
    Name = "my-instance"
  }
}