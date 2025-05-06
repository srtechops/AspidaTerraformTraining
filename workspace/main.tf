//declare Local variable

locals {
    myenv = terraform.workspace
}

resource "aws_instance" "Env" {
  ami = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  tags = {
    Name = local.myenv
    Team = "${local.myenv} Team"
  }
  security_groups = [ "default" ]
}
