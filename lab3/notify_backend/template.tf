
resource "aws_ses_template" "mail_template" {
  name = "S3StateUpdate"

  subject = "State Updated"
  
  text = <<TEXT
Hello,

env [{{env}}] updated.
bucket [{{bucket}}] updated.

Thank you for your order!
TEXT


  html = <<HTML
<html>
  <body>
    <h1h4>Hello,</h4>
    <p>env: [{{env}}] updated </p>
    <p>bucket [{{bucket}}] updated </p>
  </body>
</html>
HTML
}