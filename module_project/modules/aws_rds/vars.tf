variable "vpc_id" {}
variable "cidr_block" {}
variable "private_subnet_1a"{}
variable "private_subnet_1b"{}  
variable "db_name" {
 
    default =  "mywordpressdb"
}
variable "db_engine" {
    default = "mysql"
}
variable "engine_version" {
    default = "mywordpressdb"
}
variable "instance_class" {
    default = "db.t3.micro"
}
