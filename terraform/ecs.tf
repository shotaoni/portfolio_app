resource "aws_ecs_cluster" "tante-ecs-cluster" {
  name = "tante-ecs-cluster"
}

resource "aws_ecs_task_definition" "tante-front-task" {
  family                   = "tante-front-task"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tante_front_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_service" "tante-front-ecs-service" {
  name                              = "tante-front-ecs-service"
  cluster                           = aws_ecs_cluster.tante-ecs-cluster.arn
  task_definition                   = aws_ecs_task_definition.tante-front-task.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.tante-ecs-sg.id]

    subnets = [
      aws_subnet.public_0.id,
      aws_subnet.public_1.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tante-lb-front-tg.arn
    container_name   = "front-container"
    container_port   = "80"
  }
}

resource "aws_ecs_task_definition" "tante-api-task" {
  family                   = "tante-api-task"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tante_api_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_service" "tante-api-ecs-service" {
  name                              = "tante-api-ecs-service"
  cluster                           = aws_ecs_cluster.tante-ecs-cluster.arn
  task_definition                   = aws_ecs_task_definition.tante-api-task.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.tante-ecs-sg.id]

    subnets = [
      aws_subnet.public_0.id,
      aws_subnet.public_1.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tante-lb-api-tg.arn
    container_name   = "api-container"
    container_port   = "3000"
  }
}

resource "aws_ecs_task_definition" "db-create" {
  family                   = "tante-db-create"
  container_definitions    = file("./tante_db_create_definitions.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_task_definition" "db-migrate" {
  family                   = "tante-db-migrate"
  container_definitions    = file("./tante_db_migrate_definitions.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy" "ecs_events_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}