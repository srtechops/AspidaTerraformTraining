module "module1" {
  source = "./modules/module1"
}
module "module2" {
  source = "./modules/module2"
}

output "test" {
  value = module.module1.o1
}

output "test2" {
  value = module.module2
}