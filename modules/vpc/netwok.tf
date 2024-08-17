resource "aws_vpc" "vpctf" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC-TERRAFORM"
  }
}

output "vpc_id" {
  value = aws_vpc.vpctf.id
}
