resource "aws_route_table" "xyzpublicRT" {
  vpc_id = aws_vpc.xyzvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_internet_gateway.gw.id
  }

 

  tags = {
    Name = "xyzpublicRT"
  }
}