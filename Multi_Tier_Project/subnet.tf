resource "aws_subnet" "public_subnet_1a" {
  vpc_id     = aws_vpc.multi_tier_project.id
  cidr_block = var.SUBNET_CIDR_BLOCK_PUBLIC_1A

  tags = {
    Name = "public_subnet_1a"
  }
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id     = aws_vpc.multi_tier_project.id
  cidr_block = var.SUBNET_CIDR_BLOCK_PUBLIC_1B

  tags = {
    Name = "public_subnet_1a"
  }
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}


resource "aws_subnet" "private_subnet_1a" {
  vpc_id     = aws_vpc.multi_tier_project.id
  cidr_block = var.SUBNET_CIDR_BLOCK_PRIVATE_1A

  tags = {
    Name = "private_subnet_1a"
  }
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id     = aws_vpc.multi_tier_project.id
  cidr_block = var.SUBNET_CIDR_BLOCK_PRIVATE_1B

  tags = {
    Name = "private_subnet_1a"
  }
  availability_zone = "ap-south-1b"
}