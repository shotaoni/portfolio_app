resource "aws_cloudwatch_log_group" "tante-ecs-front" {
  name              = "/ecs/front"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "tante-ecs-api" {
  name              = "/ecs/api"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "tante-ecs-db-create" {
  name              = "/ecs/db-create"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "tante-ecs-db-migrate" {
  name              = "/ecs/db-migrate"
  retention_in_days = 180
}