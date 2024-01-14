resource "aws_vpc" "AWS_Network" {
  cidr_block       = "30.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "AWS_Network"
  }
}

resource "aws_subnet" "Private_subnet" {
  vpc_id            = aws_vpc.AWS_Network.id
  availability_zone = "us-east-1a"
  cidr_block        = "30.0.1.0/24"

  tags = {
    Name = "Private_subnet"
  }
}

### TEST
resource "aws_default_route_table" "PrivateRT" {
  default_route_table_id = aws_vpc.AWS_Network.default_route_table_id
  tags = {
    Name = "PrivateRT"
  }
}

