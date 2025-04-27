data "aws_ami" "ubuntu" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64*"]
  }
}


resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id
  subnet_id = module.network.subnets["public_subnet_1"].id
  instance_type = var.instance_type
  vpc_security_group_ids = [ module.network.public_sg.id ]
  associate_public_ip_address = true
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    "Name" = "${var.env} - Bastion Server"
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
  ami = data.aws_ami.ubuntu.id
  subnet_id = module.network.subnets["private_subnet_1"].id
  instance_type = var.instance_type
  vpc_security_group_ids = [ module.network.private_sg.id ]
  associate_public_ip_address = false
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    "Name" = "${var.env} - Private Server"
  }
  user_data = <<-EOF
#!/bin/bash
apt update -y
apt install mysql-client redis-tools -y
EOF
}


resource "null_resource" "public_ip" {
  provisioner "local-exec" {
    command = "echo IP: ${aws_instance.bastion.public_ip}"
  }
}