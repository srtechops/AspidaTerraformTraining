resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = "rds_db_subnetgroup"
  subnet_ids = [var.private_subnet_1a,var.private_subnet_1b]

  tags = {
    Name = "rds_db_subnetgroup_multi_tier_project"
  }
}