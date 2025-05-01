// string


variable "Name" {
  type    = string
  default = "Shanmuga Raja M"

}

output "o1" {
  value = var.Name

}

// Number

variable "a" {
  type    = number
  default = 10
}

output "o2" {
  value = var.a
}

// Multi-line String 

variable "multiline" {
  default = <<EOF
            Welcome to Terraform Class
            Terraform is IAC Tool
            Terraform is own by IBM
            Terraform is own by EOF
EOF



}


output "o3" {
  value = var.multiline
}

// List 


variable "mylist1" {
  type    = list(any)
  default = ["sg1", "sg2", "sg3", "sg4"]
}

output "o4" {
  value = var.mylist1[0]
}

// Boolean

variable "mybool1" {
  type    = bool
  default = true

}

output "o5" {
  value = var.mybool1
}

// Map

variable "mymap1" {
  type = map(any)
  default = {
    "Name"     = "AbcCompany"
    "Env"      = "Dev"
    "Location" = "Chennai"
  }
}

output "o6" {
  value = var.mymap1.Name
}
