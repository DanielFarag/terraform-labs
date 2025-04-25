locals {
  AMI="ami-084568db4383264d4"
  TYPE="t3.micro"
}

resource "aws_instance" "bastion" {
  ami = local.AMI
  subnet_id = aws_subnet.public_subnet.id
  instance_type = local.TYPE
  vpc_security_group_ids = [ aws_security_group.public_sg.id ]
  associate_public_ip_address = true
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    "Name" = "Bastion Server"
  }

  user_data = <<-EOF
#!/bin/bash
mkdir -p /home/ubuntu/.ssh
echo "${tls_private_key.ec2_key.private_key_pem}" > /home/ubuntu/.ssh/id_rsa
chmod 600 /home/ubuntu/.ssh/id_rsa
chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
EOF
}


resource "aws_instance" "application" {
  ami = local.AMI
  subnet_id = aws_subnet.private_subnet.id
  instance_type = local.TYPE
  vpc_security_group_ids = [ aws_security_group.private_sg.id ]
  associate_public_ip_address = false
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    "Name" = "Private Server"
  }
}