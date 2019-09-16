# Create an Internet Gateway.
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Grant Internet access to the custom VPC. This will add an entry in the main route table.
resource "aws_route" "internet_route_table" {
  route_table_id         = aws_vpc.main-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}
