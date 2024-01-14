resource "aws_instance" "AWS_EC2" {
  ami                         = "ami-0c0b74d29acd0cd97"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public-key.key_name
  subnet_id                   = aws_subnet.Private_subnet.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.AWS_EC2_SG.id]

  tags = {
    Name = "AWS_EC2"
  }
}
