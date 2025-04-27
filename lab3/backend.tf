terraform {
  backend "s3" {
    bucket = "aws-terraform-iti-state"
    key    = "lab3/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}