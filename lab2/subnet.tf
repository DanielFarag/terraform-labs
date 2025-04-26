resource "aws_subnet" "subnets" {
  for_each = { for idx, subnet in var.subnets : subnet.name => subnet }
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block
  tags = {
    "Type" = each.value.public ? "Public" : "Private"
    "Name" = each.value.name 
  }
}