variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "A map of subnet IDs"
  type        = map(string)
}


resource "aws_internet_gateway" "intenet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Internet-gateway-terraform"
  }
  
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.intenet_gateway.id
  }

  tags = {
    Name = "Route Publica"
  }
}

resource "aws_route_table_association" "public" {
  for_each = {
    subnet1 = var.subnets.subnet1
    subnet3 = var.subnets.subnet3
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Route Privada"
  }
}

resource "aws_route_table_association" "private" {
  for_each = {
    subnet2 = var.subnets.subnet2
    subnet4 = var.subnets.subnet4
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
