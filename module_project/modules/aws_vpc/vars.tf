variable "VPC_CIDR_BLOCK" {
  default = "10.0.0.0/16"
}

variable "SUBNET_CIDR_BLOCK_PUBLIC_1A" {
  default = "10.0.1.0/24"
}


variable "SUBNET_CIDR_BLOCK_PUBLIC_1B" {
  default = "10.0.2.0/24"
}


variable "SUBNET_CIDR_BLOCK_PRIVATE_1A" {
  default = "10.0.3.0/24"
}

variable "SUBNET_CIDR_BLOCK_PRIVATE_1B" {
  default = "10.0.4.0/24"
}