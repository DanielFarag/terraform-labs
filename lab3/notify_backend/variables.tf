variable "bucket" {
  description = "register_emails"
  type = object({
    id = string
    arn = string
  })
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