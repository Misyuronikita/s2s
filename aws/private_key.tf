resource "tls_private_key" "public-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "public-key" {
  key_name   = "public-key"
  public_key = tls_private_key.public-key.public_key_openssh

  tags = {
    Name = "public-key"
  }
}

resource "local_file" "ssh-key" {
  filename = "${aws_key_pair.public-key.key_name}.pem"
  content  = tls_private_key.public-key.private_key_pem
}
