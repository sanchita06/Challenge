resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc main"
  }
}

output "output_vpc"  {
  value = aws_vpc.vpc_main.id
}

resource "aws_subnet" "public_subnet_1" {

  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.az_A

    tags              = {
    Name              = "public subnet1"
    }
  
}

output "output_public_subnet_1" {
  value = aws_subnet.public_subnet_1.id
}

resource "aws_subnet" "public_subnet_2" {

  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.az_B

    tags              = {
    Name              = "public subnet2"
    }
  
}

output "output_public_subnet_2" {
  value = aws_subnet.public_subnet_2.id
}


resource "aws_subnet" "private_subnet_1" {

  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.az_A

    tags              = {
    Name              = "private subnet1"
    }
  
}

output "output_private_subnet_1" {
  value = aws_subnet.private_subnet_1.id
}

resource "aws_subnet" "private_subnet_2" {

  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = var.az_B

    tags              = {
    Name              = "private subnet2"
    }
  
}

output "output_public_subnet_2" {
  value = aws_subnet.public_subnet_2.id 
}

resource "aws_db_subnet_group" "db_subnet_group" {
    
    name             = "db_subnet_group"
    subnet_ids       = [aws_subnet.privatesubnet3.id, aws_subnet.privatesubnet4.id]

    tags             = {

    name             = "RDS Subnet Group"
    }
  
}

output "output_db_subnet_group" {
  value = aws_db_subnet_group.rdsubnetgroup.id
}

