data "aws_availability_zones" "available" {}

# Get the Ubuntu 18.04 Server AMI id
data "aws_ami" "ubuntu-18-04-srv" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}