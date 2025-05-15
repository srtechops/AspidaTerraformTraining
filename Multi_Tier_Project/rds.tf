provider "vault" {
  address = "http://3.109.3.189:8200/"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "a77b35ed-0b0d-30a1-a5f5-5b97d4f2b08b"
      secret_id = "77586153-e596-d63f-be6c-323abb4bc63e"
    }
  }
}


data "vault_kv_secret_v2" "example" {
  mount = "kv"
   name  = "test-secret"
}


resource "aws_db_instance" "wordpress_rds_db" {
    depends_on = [ aws_db_subnet_group.rds_db_subnet_group, aws_security_group.allow_mysql_rds ]
  allocated_storage    = 10
  db_name              = "mywordpressdb"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             =  data.vault_kv_secret_v2.example.data["password"]
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = "rds_db_subnetgroup"
  vpc_security_group_ids = [aws_security_group.allow_mysql_rds.id]
}


output "o1" {
   value = aws_db_instance.wordpress_rds_db.endpoint
}