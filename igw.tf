

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.semaphore.id
  tags = {
    Network = "Public"
    Name    = join("", [var.vpc_name, "-IGW"])
  }
}
