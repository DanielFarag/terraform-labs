resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "${path.module}/secret.pem"
  content  = tls_private_key.ec2_key.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ssh-secret"
  public_key = tls_private_key.ec2_key.public_key_openssh
}