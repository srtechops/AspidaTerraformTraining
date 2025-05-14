resource "aws_route_table_association" "multi_tier_project_public_rt_subnet_association_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.multi_tier_project_public_rt.id
}


resource "aws_route_table_association" "multi_tier_project_public_rt_subnet_association_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.multi_tier_project_public_rt.id
}