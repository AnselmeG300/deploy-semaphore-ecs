resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "eip-semaphore"
  }
}

resource "aws_eip" "nat_eip1" {
  count  = var.activated_auto_scaling ? 1 : 0
  domain = "vpc"
}