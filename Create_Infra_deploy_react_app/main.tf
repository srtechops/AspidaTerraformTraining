resource "aws_instance" "react_app" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"
  key_name      = "reactapp"
  tags = {
    Name = "reactApp"
  }
  security_groups = ["default"]
}


resource "null_resource" "reactapp_deploy" {
  depends_on = [aws_instance.react_app]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\SHANMUGA RAJA\\Downloads\\reactapp.pem")
    host        = aws_instance.react_app.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo yum install git -y",
      "curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -", # Install Node.js 18
      "sudo yum install -y nodejs",
      "sudo systemctl start httpd",
      "sudo git clone https://github.com/srtechops/reactProject.git",
      "cd reactProject && sudo npm install && sudo npm run build",
      "sudo cp -r build/* /var/www/html/",
      "sudo systemctl restart httpd"




    ]
  }
}