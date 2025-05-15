terraform {
  backend "s3" {
    bucket = "srtechops-s3-bucket"
    key    = "srtechops/terraform.tfstate"
    region = "us-east-1"
  }
}
