resource "tls_private_key" "Router-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "Router-key" {
  key_name   = "Router-key"
  public_key = tls_private_key.Router-key.public_key_openssh

  tags = {
    Name = "Router-key"
  }
}

resource "local_file" "ssh-key" {
  filename = "${aws_key_pair.Router-key.key_name}.pem"
  content  = tls_private_key.Router-key.private_key_pem
}
