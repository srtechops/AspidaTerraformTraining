provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "srtechops-s3-bucket"
}

resource "aws_instance" "TestVM" {
  ami = "ami-0953476d60561c955"
  instance_type = "t2.micro"
  tags = {
    Name = "NewVM"
  }


}