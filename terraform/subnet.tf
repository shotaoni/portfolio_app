resource "aws_subnet" "public_0" {
  vpc_id                  = aws_vpc.tante-vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "public_0"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.tante-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "public_1"
  }
}

resource "aws_subnet" "private_0" {
  vpc_id                  = aws_vpc.tante-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "private_0"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.tante-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "private_1"
  }
}

resource "aws_db_subnet_group" "tante-rds-subnet-group" {
  name        = "tante_rds_subnet_group"
  description = "rds subnet group for tante"
  subnet_ids  = [aws_subnet.private_0.id, aws_subnet.private_1.id]
}