module "aws_vpc" {
   source = "./modules/aws_vpc"
}

module "aws_rds" {
  source = "./modules/aws_rds"
  vpc_id = module.aws_vpc.vpc_id
  cidr_block = module.aws_vpc.VPC_CIDR_BLOCK
  private_subnet_1a = module.aws_vpc.private_subnet_1a
  private_subnet_1b = module.aws_vpc.private_subnet_1b

}

output "db_endpoint" {
  value = module.aws_rds.o1
}

module "aws_wordpress" {
  source = "./modules/aws_wordpress"
  public_subnet_1a = module.aws_vpc.public_subnet_1a
  vpc_id = module.aws_vpc.vpc_id
}