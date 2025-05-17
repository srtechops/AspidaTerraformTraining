output "ui_address" {
    description = "Public IP"
  value = "http://${aws_instance.my_instance.public_ip}/"
}
output "server_address" {
    description = "Public IP Server"
  value = "http://${aws_instance.my_instance.public_ip}:3000/"
}
output "public_dns" {
    description = "Public DNS"
  value = aws_instance.my_instance.public_dns
}