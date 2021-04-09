resource "aws_lb" "tante-lb" {
  name                       = "tante-lb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    aws_subnet.public_0.id,
    aws_subnet.public_1.id
  ]

  security_groups = [
    aws_security_group.tante-alb-sg.id
  ]

  tags = {
    Name = "tante-lb"
  }
}

resource "aws_lb_listener" "tante-http-listener" {
  load_balancer_arn = aws_lb.tante-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "tante-https-listener" {
  load_balancer_arn = aws_lb.tante-lb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.tante-acm-certificate.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    target_group_arn = aws_lb_target_group.tante-lb-front-tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "tante-api-listener" {
  load_balancer_arn = aws_lb.tante-lb.arn
  port              = "3000"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.tante-acm-certificate.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    target_group_arn = aws_lb_target_group.tante-lb-api-tg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tante-lb-front-tg" {
  name                 = "tante-lb-front-tg"
  target_type          = "ip"
  vpc_id               = aws_vpc.tante-vpc.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    enabled = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 120
    interval            = 150
    matcher             = 200
    port                = 80
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.tante-lb]
}

resource "aws_lb_target_group" "tante-lb-api-tg" {
  name                 = "tante-lb-api-tg"
  target_type          = "ip"
  vpc_id               = aws_vpc.tante-vpc.id
  port                 = 3000
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    enabled             = true
    path                = "/v1/tasks"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 50
    interval            = 150
    matcher             = 200
    port                = 3000
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.tante-lb]
}
