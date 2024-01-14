resource "aws_instance" "On_Premises_Router" {
  ami                         = "ami-0c84181f02b974bc3"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.Router-key.key_name
  subnet_id                   = aws_subnet.Public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.On_Premises_Router_SG.id]
  tags = {
    Name = "On_Premises_Router"
  }
}

resource "local_file" "public_ip" {
  filename = "my_ip.txt"
  content  = aws_instance.On_Premises_Router.public_ip
}
