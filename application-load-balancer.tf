# Create a security group for the Application Load Balancer, open port: 80.
resource "aws_security_group" "security-group-application-load-balancer" {
  name        = "security-group-application-load-balancer"
  description = "Application Load Balancer security group"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

# Create an Application Load Balancer.
resource "aws_alb" "application-load-balancer" {
  name            = "application-load-balancer"
  security_groups = [aws_security_group.security-group-application-load-balancer.id]
  subnets         = aws_subnet.main.*.id
  tags = {
    Name = "${var.project_name}-alb"
  }
}

# Create a target group and define stickiness
resource "aws_alb_target_group" "alb-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main-vpc.id

  stickiness {
    # Enable stickiness
    type = "lb_cookie"
    # Set cookie duration to one hour (3600s)
    cookie_duration = 3600
  }

  # The ALB will look for the "health_check" file to determine instances health
  health_check {
    path = "/health_check"
    port = 80
  }
  tags = {
    Name = "${var.project_name}-alb-tg"
  }
}

# Add a listener on port 80
resource "aws_alb_listener" "application-load-balancer-listener-http" {
  load_balancer_arn = aws_alb.application-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb-target-group.arn
    type             = "forward"
  }
}