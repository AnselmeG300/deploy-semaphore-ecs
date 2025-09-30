resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.nat_eip.allocation_id
}


resource "aws_nat_gateway" "nat_gateway1" {
  count         = var.activated_auto_scaling ? 1 : 0
  subnet_id     = aws_subnet.public_subnet1.id
  allocation_id = aws_eip.nat_eip1[0].allocation_id
}