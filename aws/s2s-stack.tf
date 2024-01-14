resource "aws_customer_gateway" "On_Premises_Network_Gateway" {
  bgp_asn    = 65000
  type       = "ipsec.1"
  ip_address = file("../on-premises/my_ip.txt")
  tags = {
    Name = "On_Premises_Network_Gateway"
  }
}

resource "aws_vpn_gateway" "AWS_Network_VPG" {
  vpc_id = aws_vpc.AWS_Network.id

  tags = {
    Name = "AWS_Network_VPG"
  }
}

resource "aws_vpn_gateway_attachment" "AWS_Network_VPG_attachment" {
  vpc_id         = aws_vpc.AWS_Network.id
  vpn_gateway_id = aws_vpn_gateway.AWS_Network_VPG.id
}

resource "aws_vpn_gateway_route_propagation" "AWS_Network_VPG_propagation" {
  vpn_gateway_id = aws_vpn_gateway.AWS_Network_VPG.id
  route_table_id = aws_default_route_table.PrivateRT.id
}

resource "aws_vpn_connection" "AWS_On_Premises_Connection" {
  vpn_gateway_id        = aws_vpn_gateway.AWS_Network_VPG.id
  customer_gateway_id   = aws_customer_gateway.On_Premises_Network_Gateway.id
  type                  = "ipsec.1"
  static_routes_only    = true
  tunnel1_preshared_key = "abc123xyz987"
}

resource "aws_vpn_connection_route" "AWS_On_Premises_Connection_Route" {
  destination_cidr_block = "10.0.0.0/16"
  vpn_connection_id      = aws_vpn_connection.AWS_On_Premises_Connection.id
}
