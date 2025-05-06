resource "aws_instance" "Env" {
  ami = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  tags = {
    Name = "Dev"
  }
  security_groups = [ "default" ]
}