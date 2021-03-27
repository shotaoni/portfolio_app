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

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}