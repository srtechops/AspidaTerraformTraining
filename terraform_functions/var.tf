locals {
  a = "test"
}

output "hello" {
  value = local.a
}

