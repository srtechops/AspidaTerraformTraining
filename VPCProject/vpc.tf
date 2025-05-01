resource "aws_vpc" "xyzvpc" {
  cidr_block       = var.aws_vpc_cidr_range
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }

  enable_dns_hostnames = true
  enable_dns_support   = true
}