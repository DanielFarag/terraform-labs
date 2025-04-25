resource "aws_security_group" "public_sg" {
  name = "public-sg"
  vpc_id = aws_vpc.main_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "TCP"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Public Sq"
  }
}

resource "aws_security_group" "private_sg" {
  name = "private-sg"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    cidr_blocks = [ aws_vpc.main_vpc.cidr_block ]

    protocol = "TCP"
  }

  ingress {
    from_port = 3000
    to_port = 3000
    cidr_blocks = [ aws_vpc.main_vpc.cidr_block ]
    protocol = "TCP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Private Sq"
  }
}

