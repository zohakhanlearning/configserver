# ec2.tf
resource "aws_instance" "zoha_instance" {
  ami           = "ami-0b0ea68c435eb488d" # Example AMI ID, choose one appropriate for your region and needs
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id
  associate_public_ip_address = true

  tags = {
    Name = "zoha-instance"
  }
}