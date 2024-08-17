terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.62.0"
    }
  }
  backend "s3" {
    bucket = "aldo-curso-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "aldo"
      managed-by = "terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

}

module "subnet" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source  = "./modules/route_tables"
  vpc_id  = module.vpc.vpc_id
  subnets = module.subnet.subnets
}

module "aws_s3_bucket" {
  source = "./modules/buckets"
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  # key_name = "tcb-blog" # Insira o nome da chave criada antes.
  subnet_id = module.subnet.subnets.subnet1

  tags = {
    Name = "blogserver01"
 # Insira o nome da instância de sua preferência.
  }
}















