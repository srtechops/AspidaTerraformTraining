resource "aws_security_group" "allow_http_ssh_wordpress" {
  name        = "Allow ssh and http for wordpresapp"
  description = "Allow http and ssh inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_http_ssh_wordpress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4_wordpress" {
  security_group_id = aws_security_group.allow_http_ssh_wordpress.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    Name = "allow_ssh_ipv4_wordpress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_wordpress" {
  security_group_id = aws_security_group.allow_http_ssh_wordpress.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  tags = {
    Name = "allow_http_ipv4_wordpress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_wordpress_outbound" {
  security_group_id = aws_security_group.allow_http_ssh_wordpress.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags = {
    Name = "allow_all_traffic_ipv4_wordpress_outbound"
  }
}

