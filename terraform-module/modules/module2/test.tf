output "o1" {
  value = "Welcome to module 2"
}

module "module1" {
  source = "../module1"
}

output "o2" {
    value = module.module1.o1
}
