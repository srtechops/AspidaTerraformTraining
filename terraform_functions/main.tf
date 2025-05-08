locals {
  region = split("-","ap-south-1a")
  message = "Welcome to Terrafrom Training"
  a = "hello\n\n"
  b = "  \nhello\n\n"
  c = "us-east-1"
 
}



// max()


output "o1" {
  value = max(2,5)
}


// min()

output "o2" {
  value = min(1,2)
}

// split()

output "o3" {
#   value = local.region[2]
value = local.region
}

// join()

output "o4" {
  value = join("-",local.region)
}

// lower()

output "o5" {
  value = lower("WELCOME")
}

output "o6"{
    value = upper("hello")
}

//substr()

output "o7" {
  value = substr(local.message,3,4)
}

// startswith()

output "o8" {
  value = startswith(local.message,"Welcome")
}


//endswith()

output "o9" {
  value = endswith(local.message,"Training")
}

//chomp()

output "o10" {
  value = chomp(local.a)
}

// trimspace

output "o11"{
    value = trimspace(local.b)
}

// replace 

output "o12" {
  value = replace(local.c,"-","+")
}