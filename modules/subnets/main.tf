variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

resource "aws_subnet" "subnet1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet-2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "Subnet-3"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Name = "Subnet-4"
  }
}

output "subnets" {
  value = {
    subnet1 = aws_subnet.subnet1.id
    subnet2 = aws_subnet.subnet2.id
    subnet3 = aws_subnet.subnet3.id
    subnet4 = aws_subnet.subnet4.id
  }
}
