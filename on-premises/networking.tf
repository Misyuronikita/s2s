resource "aws_vpc" "On_Premises_Network" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "On_Premises_Network"
  }
}

resource "aws_subnet" "Public_subnet" {
  vpc_id            = aws_vpc.On_Premises_Network.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "Public_subnet"
  }
}

resource "aws_internet_gateway" "On_Premises_IGW" {
  tags = {
    Name = "On_Premises_IGW"
  }
}

resource "aws_internet_gateway_attachment" "On_Premises_IGW_attachment" {
  internet_gateway_id = aws_internet_gateway.On_Premises_IGW.id
  vpc_id              = aws_vpc.On_Premises_Network.id
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.On_Premises_Network.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.On_Premises_IGW.id
  }

  tags = {
    Name = "PublicRT"
  }
}

resource "aws_route_table_association" "PublicRT_association" {
  route_table_id = aws_route_table.PublicRT.id
  subnet_id      = aws_subnet.Public_subnet.id
}
