# Set the desired region and the project name.
region       = "eu-west-2"
project_name = "terra"

# Choose an existing public key you would like to use.
public_key = "London"

# Set the allowed CIDR blocks.
allowed_cidr_blocks        = ["0.0.0.0/0"]
http_srv_instance_type     = "t2.micro"

# Auto scalling group settings:
autoscaling_group_min_size = 3
autoscaling_group_max_size = 5
