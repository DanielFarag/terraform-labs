variable "region" {
  description = "define region"
  type = string
}

variable "env" {
  description = "specify enviomrent"
  type = string
}




variable "s3_bicket_state_name" {
  description = "Store bucket name"
  default = "aws-terraform-iti-state"
  type = string
}




variable "register_emails" {
  description = "register_emails"
  type = list(string)
}

variable "ses_email_sender" {
  description = "ses_email_sender"
  type = string
}

variable "s3_email_reciever" {
  description = "s3_email_reciever"
  type = list(string)
}





variable "instance_type" {
  description = "define instance type"
  type = string
}






variable "vpc_cidr_block" {
  description = "define vpc cider block"
  type = string
}
variable "subnets" {
  description = "define subnets"
  type = list(object({
    name =  string
    availability_zone =  string
    cidr_block = string
    public = bool
  }))
}







variable "rds" {
  description = "define rds confugraion"
  type = object({
    allocated_storage    = number
    db_name              = string
    engine               = string
    engine_version       = string
    instance_class       = string
    username             = string
    password             = string
    parameter_group_name = string
    skip_final_snapshot  = bool
  })
}

variable "redis" {
  description = "define rds confugraion"
  type = object({
    description                   = string 
    replication_group_id          = string 
    node_type                     = string 
    engine                        = string 
    engine_version                = string 
    port                          = number
    automatic_failover_enabled    = bool 
    transit_encryption_enabled    = bool 
  })
}