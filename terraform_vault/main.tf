provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://3.109.3.189:8200/"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "a77b35ed-0b0d-30a1-a5f5-5b97d4f2b08b"
      secret_id = "77586153-e596-d63f-be6c-323abb4bc63e"
    }
  }
}


data "vault_kv_secret_v2" "example" {
  mount = "kv"
   name  = "test-secret"
}

resource "aws_instance" "myvm1" {
  ami           = "ami-0953476d60561c955"
  instance_type = "t2.micro"
  tags = {
    Name = data.vault_kv_secret_v2.example.data["password"]
    
  }

}