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
    key_name = "TerraformTrainingKey"
    subnet_id = aws_subnet.my_vpc_subnet.id
    security_groups = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
    
}

resource "null_resource" "my_null_resource" {
    depends_on = [ aws_instance.my_instance, aws_security_group.allow_ssh ]

    connection {
      host = aws_instance.my_instance.public_ip
      user = "ec2-user"
      private_key = file("/Users/namohaimin/Downloads/TerraformTrainingKey.pem")
    }

    provisioner "remote-exec" {
      inline = [ 
        "echo \"⚡️ Installing GIT ...\"",
        "sudo yum install git -y",
        "echo \"⚡️ Copying GH Key ...\"",
        "mkdir /home/ec2-user/keys",
       ]
    }

    provisioner "file" {
      source = "/Users/namohaimin/Develop/Keys/ghkey_terraform"
      destination = "/home/ec2-user/keys/ghkey_terraform"
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod 600 /home/ec2-user/keys/ghkey_terraform",
        "eval $(ssh-agent -s)",
        "ssh-add /home/ec2-user/keys/ghkey_terraform",
        "mkdir -p ~/.ssh",
        "ssh-keyscan github.com >> ~/.ssh/known_hosts",
        "mkdir -p /home/ec2-user/app",
        "cd /home/ec2-user/app",
        "echo \"⚡️ Cloning GH Repos ...\"",
        "git clone git@github.com:mohaimin95/ui-terraform-training.git",
        "git clone git@github.com:mohaimin95/server-terraform-training.git",
        "git clone git@github.com:mohaimin95/docker-terraform-training.git",
        "sudo yum update -y",
        "echo \"⚡️ Installing Docker ...\"",
        "sudo amazon-linux-extras enable docker",
        "sudo yum install -y docker",
        "sudo systemctl start docker",
        "sudo systemctl enable docker",
        "sudo usermod -aG docker ec2-user",
        "echo \"⚡️ Installing Docker Compose ...\"",
        "sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
        "sudo chmod +x /usr/local/bin/docker-compose",
        "cd /home/ec2-user/app/docker-terraform-training",
        "export PORT=80",
        "echo \"⚡️ Building ...\"",
        "sudo docker-compose up --build -d",
        "echo \"✅ DONE ...\"",
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