resource "aws_security_group" "tante-rds-sg" {
  description = "RDS security group for tante"
  name        = "tante-rds-sg"
  vpc_id      = aws_vpc.tante-vpc.id
}

resource "aws_security_group" "tante-alb-sg" {
  description = "ALB security group for tante"
  name        = "tante-alb-sg"
  vpc_id      = aws_vpc.tante-vpc.id
}

resource "aws_security_group" "tante-ecs-sg" {
  description = "ECS security group for tante"
  name        = "tante-ecs-sg"
  vpc_id      = aws_vpc.tante-vpc.id
}