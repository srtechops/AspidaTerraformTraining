resource "aws_vpc" "multi_tier_project" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "multi_tier_project"
  }
  enable_dns_hostnames = true
  enable_dns_support   = true
}