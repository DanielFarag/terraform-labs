resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.2.0/24"
}

