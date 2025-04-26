terraform {
  backend "s3" {
    bucket = "aws-ansible-terraform-state"
    key    = "lab2/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}