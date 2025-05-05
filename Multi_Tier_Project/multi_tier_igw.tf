resource "aws_internet_gateway" "multi_tier_project_gw" {
  vpc_id = aws_vpc.multi_tier_project.id

  tags = {
    Name = "multi_tier_project_gw"
  }
}