# This is a simple launch configuration for the auto scaling group.
resource "aws_launch_configuration" "launch_configuration-http_srv" {
  name_prefix     = "launch_configuration-http_srv"
  image_id        = data.aws_ami.ubuntu-18-04-srv.id
  instance_type   = var.http_srv_instance_type
  key_name        = var.public_key
  security_groups = [aws_security_group.security_group-ec2-http-ssh-icmp.id]

  # Attache user data from the setup.sh file.
  user_data = file("setup.sh")

  # This will associate a public address to all new EC2 instances.
  associate_public_ip_address = true
  enable_monitoring           = true

  lifecycle {
    create_before_destroy = true
  }
}
