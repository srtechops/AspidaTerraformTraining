provider "aws"{
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}



resource "aws_instance" "VM1" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  key_name = "terraformTraining"
  tags = {
    Name = "UserdataScriptVM"
  }
  user_data = <<-EOF
             #!/bin/bash
             yum install git -y
             mkdir Welcome
             touch sample.txt
             EOF
}