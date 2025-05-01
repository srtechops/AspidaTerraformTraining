provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}


resource "aws_instance" "DevVM" {

  ami           = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  key_name      = "terraformTraining"
  tags = {
    "Name" = "Hello"
  }
  security_groups = ["TerraformVolumeProject"]

}

resource "aws_ebs_volume" "DevVol" {
  depends_on        = [aws_instance.DevVM]
  availability_zone = aws_instance.DevVM.availability_zone
  size              = 10

  tags = {
    Name = "AddOnVolume"
  }

}

resource "aws_volume_attachment" "VolumeAttachment" {
  depends_on  = [aws_ebs_volume.DevVol]
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.DevVol.id
  instance_id = aws_instance.DevVM.id
}

resource "null_resource" "nullremote1" {

  depends_on = [aws_volume_attachment.VolumeAttachment]

  provisioner "remote-exec" {

    inline = [
      "sudo mkfs -t ext4 -F /dev/sdb",
      "sudo yum install httpd -y",
      "sudo mount /dev/sdb /var/www/html",
      "echo '<h1>Welcome to Terraform Training</h1>' | sudo tee /var/www/html/index.html",
      "sudo systemctl start httpd"
    ]

  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\SHANMUGA RAJA\\Downloads\\terraformTraining.pem")
    host        = aws_instance.DevVM.public_ip
  }
}