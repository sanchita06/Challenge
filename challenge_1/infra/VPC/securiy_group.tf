# Bastion

resource "aws_security_group" "ssh_all" {
    
    name            = "bastion_ssh_all_sg_darwin"
    description     = "Allow SSH from Anywhere"
    vpc_id          = aws_vpc.vpc_main.id

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [aws_vpc.vpc_main.cidr_block]
    }

    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = "0.0.0.0/0"

    }

    tags            = {  
    Name            = "allow_all_network"
    }
}

output "output_allow_all" {
  value = aws_security_group.ssh_all.id
}

## SSH from Bastion

resource "aws_security_group" "ssh_from_nat" {
    name             = "ssh_from_bastion_nat"
    description      = "Allow SSH from Bastion Host"
    vpc_id           = aws_vpc.vpc_main.id

    ingress {
     from_port       = 443
     to_port         = 443
     protocol        = "tcp"
     security_groups = [
                        aws_security_group.ssh_all.id,
                        aws_security_group.private_sg.id

     ]
    }
  
}

output "output_ssh_from_nat" {
  value = aws_security_group.ssh_all.id
}

#Application Load Balancer

resource "aws_security_group" "external_alb_sg" {
    
    name        = "external_alb_sg"
    description = "Allow port 80 from Anywhere"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }

    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = "0.0.0.0/0"

    }

    tags            = {
        
    Name            = "External Load Balancer Security Group"
    }

    vpc_id          = aws_vpc.vpc_main.id
  
}

output "output_external_alb_sg" {
  value = aws_security_group.external_alb_sg.id
}

# Internal Application Load Balancer

resource "aws_security_group" "internal_alb_sg" {
    
    name        = "internal_alb_sg"
    description = "Allow port 3000 from Private"

    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = "10.0.3.0/24"
    }

      ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = "10.0.4.0/24"
    }

    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = "10.0.3.0/24"

    }

     egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = "10.0.4.0/24"

    }

    tags            = {
        
    Name            = "Internal Load Balancer Security Group"
    }

    vpc_id          = aws_vpc.vpc_main.id
  
}

output "output_internal_alb_sg" {
  value = aws_security_group.internal_alb_sg.id
}

## Private Subnet

resource "aws_security_group" "private_sg" {

    name                    = "private_subnet"
    description             = "to expose to web using nat instance"
    vpc_id                  = aws_vpc.vpc_main.id

   ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = [aws_subnet.private_subnet_1.cidr_block]
    }

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = [aws_subnet.private_subnet_2.cidr_block]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = -1
        cidr_blocks     = "0.0.0.0/0"
    }

    tags = {
        Name = "private subnet internet exposure - nat gateway"
    }
  
}

output "output_private_sg" {
  value = aws_security_group.private_sg.id
}

## Public Subnet


resource "aws_security_group" "public_sg" {

    name                    = "public_subnet"
    description             = "Internet exposure t private subnet via nat"
    vpc_id                  = aws_vpc.vpc_main.id


    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = [aws_subnet.public_subnet_1.cidr_block]
    }

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = [aws_subnet.public_subnet_1.cidr_block]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = -1
        cidr_blocks     = "0.0.0.0/0"
    }

    tags = {
        Name = "public subnet internet exposure - nat gateway"
    }
  
}

output "output_public_sg" {
  value = aws_security_group.public_sg.id
}


# Database SG

resource "aws_security_group" "database_sg" {

    name                    = "db_sg"
    description             = "Internet exposure to RDS"
    vpc_id                  = aws_vpc.vpc_main.id

     ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = [aws_subnet.private_subnet_1.cidr_block]
    }

    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = [aws_subnet.private_subnet_1.cidr_block]
    }

      ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = [aws_subnet.private_subnet_2.cidr_block]
    }

    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = [aws_subnet.private_subnet_2.cidr_block]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = -1
        cidr_blocks     = "0.0.0.0/0"
    }

    tags = {
        Name = "RDS SG"
    }
  
}

output "output_database_sg" {
  value = aws_security_group.database_sg.id
}








