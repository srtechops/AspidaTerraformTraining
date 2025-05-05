resource "aws_instance" "wordpress_app" {
  depends_on    = [aws_security_group.allow_http_ssh_wordpress]
  ami           = "ami-03edbe403ec8522ed"
  instance_type = "t2.micro"
  key_name      = "wordpress"
  tags = {
    Name = "wordpressapp"
  }
  vpc_security_group_ids = [aws_security_group.allow_http_ssh_wordpress.id]
  subnet_id = aws_subnet.public_subnet_1a.id
}


resource "null_resource" "wordpresapp_deploy" {
  depends_on = [aws_instance.wordpress_app]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\SHANMUGA RAJA\\Downloads\\wordpress.pem")
    host        = aws_instance.wordpress_app.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo yum install git -y",
      "sudo amazon-linux-extras install -y mariadb10.5 php8.2",
      "sudo git clone https://github.com/WordPress/WordPress.git /var/www/html",
      "sudo chown -R apache /var/www/html",
      "sudo systemctl restart httpd"

    ]
  }

}

