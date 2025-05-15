provider "aws" {
    region = "ap-south-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "aws_vpc" "my_vpc" {
    tags = {
      Name = "MyPublicVPC"
    }
    instance_tenancy = "default"
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
}

resource "aws_subnet" "my_vpc_subnet" {
  tags = {
    Name = "my_vpc_subnet"
  }

  depends_on = [ aws_vpc.my_vpc ]
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Routing Table"
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.my_vpc_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "allow_http" {
  tags = {
    Name = "allow_http"
  }
    description = "HTTP SG"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = "Inbound Rule"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound Rule"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "allow_server" {
  tags = {
    Name = "allow_server"
  }
    description = "server SG"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = "Inbound Rule"
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound Rule"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}


resource "aws_instance" "my_instance" {
    tags = {
      Name = "my_instance"
    }

    ami = "ami-0af9569868786b23a"
    instance_type = "t2.micro"
    key_name = "KeyPairThoughtfocus"
    subnet_id = aws_subnet.my_vpc_subnet.id
    security_groups = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id, aws_security_group.allow_server.id]
    
}

resource "null_resource" "my_null_resource" {
    depends_on = [ aws_instance.my_instance ]

    connection {
      host = aws_instance.my_instance.public_ip
      user = "ec2-user"
      private_key = file("D:\\projects\\ui-terraform-training\\terraform-scripts\\KeyPairThoughtfocus.pem")
    }

    provisioner "remote-exec" {
      inline = [ 
        "sudo yum install git -y",
        "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash",
        "source ~/.bashrc",
        "nvm install --lts",
        "node -e \"console.log('Running Node.js ' + process.version)\"",
        "mkdir /home/ec2-user/keys",
       ]
    }

    provisioner "file" {
      source = "D:\\Abdul\\Keys\\abdul_key2"
      destination = "/home/ec2-user/keys/abdul_key2"
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod 600 /home/ec2-user/keys/abdul_key2",
        "eval $(ssh-agent -s)",
        "ssh-add /home/ec2-user/keys/abdul_key2",
        "mkdir -p ~/.ssh",
        "ssh-keyscan github.com >> ~/.ssh/known_hosts",
        "mkdir -p /home/ec2-user/app",
        "cd /home/ec2-user/app",
        "git clone git@github.com:mohaimin95/ui-terraform-training.git",
        "cd ui-terraform-training",
        "npm install",
        "npm run build",
        "sudo yum install -y httpd",
        "sudo cp -r dist/* /var/www/html/",
        "sudo chown -R apache:apache /var/www/html/",
        "sudo chmod -R 755 /var/www/html/",
        "sudo systemctl enable httpd",
        "sudo systemctl start httpd",
        "cd /home/ec2-user/app",
        "git clone git@github.com:mohaimin95/server-terraform-training.git",
        "cd server-terraform-training",
        "npm install",
        "npm run build",
        "npx -y pm2 start dist/index.js",
       ]
    }
}

# resource "aws_db_instance" "my_db" {
#     allocated_storage = 10
#     db_name = "my_test_db"
#     engine = "mysql"
#     engine_version = "8.0"
#     instance_class = "db.t3.micro"
#     username = 
# }