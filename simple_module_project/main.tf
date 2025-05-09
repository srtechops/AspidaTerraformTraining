module "aws_vpc" {
   source = "./modules/aws_vpc"
}


module "aws_security_group" {
  source = "./modules/aws_sg"
  vpc_id = module.aws_vpc.vpc_id

}