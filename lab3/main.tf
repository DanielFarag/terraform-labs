
resource "aws_s3_bucket" "state" {
  bucket = var.s3_bicket_state_name
  provider = aws.aws_s3_region
  lifecycle {
    prevent_destroy = true
  }
}

module "notify_backend" {
  count               = var.region == aws_s3_bucket.state.region ? 1 : 0 # current region is the bucket-region
  source              = "./notify_backend"
  bucket              = aws_s3_bucket.state
  register_emails     = var.register_emails
  ses_email_sender    = var.ses_email_sender
  s3_email_reciever   = var.s3_email_reciever
}


module "network" {
  source           = "./network"
  env              = var.env
  vpc_cidr_block   = var.vpc_cidr_block
  subnets          = var.subnets
}