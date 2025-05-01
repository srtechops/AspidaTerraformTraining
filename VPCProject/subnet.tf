resource "aws_subnet" "publicsubnet1a" {
 depends_on = [aws_vpc.xyzvpc]
  vpc_id     = aws_vpc.xyzvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "publicsubnet1a"
  }
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}


resource "aws_subnet" "publicsubnet1b" {
  depends_on = [aws_vpc.xyzvpc]
  vpc_id     = aws_vpc.xyzvpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "publicsubnet1b"
  }
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true
}


resource "aws_subnet" "publicsubnet1c" {
  depends_on = [aws_vpc.xyzvpc]
  vpc_id     = aws_vpc.xyzvpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "publicsubnet1c"
  }
    availability_zone = "ap-south-1c"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "privatesubnet1a" {
  depends_on = [aws_vpc.xyzvpc]
  vpc_id     = aws_vpc.xyzvpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "privatesubnet1a"
  }
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = false
}



resource "aws_subnet" "privatesubnet1b" {
  depends_on = [aws_vpc.xyzvpc]
  vpc_id     = aws_vpc.xyzvpc.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "privatesubnet1b"
  }
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = false
}


resource "aws_subnet" "privatesubnet1c" {
  depends_on = [aws_vpc.xyzvpc]
  vpc_id     = aws_vpc.xyzvpc.id
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "privatesubnet1c"
  }
    availability_zone = "ap-south-1c"
    map_public_ip_on_launch = false
}
