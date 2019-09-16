# Create a security group in the custom VPC.
resource "aws_security_group" "security_group-ec2-http-ssh-icmp" {
  name        = "security-group-default"
  description = "Terra security group"
  vpc_id      = aws_vpc.main-vpc.id

  # Allow outbound Internet access.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.security-group-application-load-balancer.id]
  }
  tags = {
    Name = "${var.project_name}-sg"
  }
}
