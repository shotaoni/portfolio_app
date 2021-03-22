resource "aws_internet_gateway" "tante-igw" {
  vpc_id = aws_vpc.tante-vpc.id

  tags = {
    Name = "tante-igw"
  }
}