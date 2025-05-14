resource "aws_route_table" "multi_tier_project_public_rt" {
  vpc_id = aws_vpc.multi_tier_project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.multi_tier_project_gw.id
  }

  tags = {
    Name = "multi_tier_project_public_rt"
  }
}