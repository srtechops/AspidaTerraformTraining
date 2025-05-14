output "vpc_id" {
   value = aws_vpc.multi_tier_project.id
}

output "VPC_CIDR_BLOCK" {
  value = aws_vpc.multi_tier_project.cidr_block
}

output "private_subnet_1a" {
  value =aws_subnet.private_subnet_1a.id
}


output "private_subnet_1b" {
  value = aws_subnet.private_subnet_1b.id
}

output "public_subnet_1a" {
  value = aws_subnet.public_subnet_1a.id
}