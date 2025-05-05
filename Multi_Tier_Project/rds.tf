resource "aws_db_instance" "wordpress_rds_db" {
    depends_on = [ aws_db_subnet_group.rds_db_subnet_group, aws_security_group.allow_mysql_rds ]
  allocated_storage    = 10
  db_name              = "mywordpressdb"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = "rds_db_subnetgroup"
  vpc_security_group_ids = [aws_security_group.allow_mysql_rds.id]
}


output "o1" {
   value = aws_db_instance.wordpress_rds_db.endpoint
}