resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.publicsubnet1a.id
  route_table_id = aws_route_table.xyzpublicRT.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.publicsubnet1b.id
  route_table_id = aws_route_table.xyzpublicRT.id
}


resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.publicsubnet1c.id
  route_table_id = aws_route_table.xyzpublicRT.id
}