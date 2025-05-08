locals {
  a = ["a","b","c"]
  b = "Welcome"
  c = {
    a="b"
    Name = "prem"
     }
   d = [["a", "b"], [], ["c"],["1","2","3","4"]]

   e = {
        dev = "t2.micro"
        prod = "t2.large"
   }
}


// length()

// length of list
output "o1" {
  value = length(local.a)
}

// length of string
output "o2" {
  value = length(local.b)
}

// length of map

output "o3" {
  value = length(local.c)
}

//contains()

output "o4" {
  value = contains(local.a, "a")
}

// fatten()

output "o5" {
  value = flatten(local.d)
}

//lookup()

output "o6" {
  value = lookup(local.e,"dev","t2.small")
}