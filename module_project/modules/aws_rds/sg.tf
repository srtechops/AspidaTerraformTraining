resource "aws_security_group" "allow_mysql_rds" {
  name        = "Allow mysql for rds"
  description = "Allow mysql inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.multi_tier_project.id

  tags = {
    Name = "allow_mysql_rdb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_rds_inbound" {
  security_group_id = aws_security_group.allow_mysql_rds.id
  cidr_ipv4         = var.VPC_CIDR_BLOCK
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
  tags = {
    Name = "allow_mysql_rds_inbound_traffic"
  }
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_rds_outbound" {
  security_group_id = aws_security_group.allow_mysql_rds.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags = {
    Name = "allow_all_traffic_ipv4_rds_outbound"
  }
}

