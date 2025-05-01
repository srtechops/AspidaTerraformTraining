provider "aws"{
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}


resource "aws_iam_user" "name" {
    count = length(var.iamuser)
   name = var.iamuser[count.index]
}


variable "iamuser" {
  default = ["prakashraj", "harinipriya", "diviya"]
}
