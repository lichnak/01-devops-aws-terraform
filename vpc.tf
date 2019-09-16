# This is where the custom VPC gets created.
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Create a subnet in each availability zone.
resource "aws_subnet" "main" {
  count      = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.${count.index}.0/24"

  # All new instances will be associated with a public IP address.
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    name = "${var.project_name}-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}