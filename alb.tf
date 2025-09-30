resource "aws_lb" "semaphore_lb" {
  name               = "semaphore-load-balancer"
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.semaphore_alb_sg.id
  ]
  subnets = [
    aws_subnet.public_subnet.id,
    aws_subnet.public_subnet1.id
  ]

  idle_timeout = 1200
}


resource "aws_lb_target_group" "semaphore_lb_tg" {
  name        = "semaphore-lb-target-group"
  vpc_id      = aws_vpc.semaphore.id
  target_type = "ip"
  port        = 3000
  protocol    = "HTTP"
  health_check {
    port = 3000
  }
}


resource "aws_lb_listener" "semaphore_front" {
  load_balancer_arn = aws_lb.semaphore_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certficate_ssl

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.semaphore_lb_tg.arn
        weight = 1
      }
    }
  }
}


resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.semaphore_lb.arn
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

