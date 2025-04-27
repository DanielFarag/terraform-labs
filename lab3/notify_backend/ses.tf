resource "aws_ses_email_identity" "notify" {
  count = length(var.register_emails)
  email = var.register_emails[count.index]
}
