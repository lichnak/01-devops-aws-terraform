# A simple auto scaling group.
resource "aws_autoscaling_group" "autoscaling_group" {
  launch_configuration = aws_launch_configuration.launch_configuration-http_srv.id
  min_size             = var.autoscaling_group_min_size
  max_size             = var.autoscaling_group_max_size
  target_group_arns    = [aws_alb_target_group.alb-target-group.arn]

  # Launch instances in all available AZs.
  vpc_zone_identifier = aws_subnet.main.*.id

  # Set the health check type to "ELB" so the load balancer can check on instances.
  health_check_type = "ELB"
}