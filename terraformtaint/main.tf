resource "aws_instance" "VM1" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  key_name = "terraformTraining"
  tags = {
    Name = "VM1"
  }
}


resource "aws_instance" "VM2" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  key_name = "terraformTraining"
  tags = {
    Name = "VM2"
  }
}


