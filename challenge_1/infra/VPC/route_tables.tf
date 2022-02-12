
# Public
resource "aws_route_table" "public" {

    vpc_id = aws_vpc.vpc_main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    tags = {
        Name = "Public Route Table"
    }
  
}

resource "aws_route_table_association" "public1" {

    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public.id

  
}

resource "aws_route_table_association" "public2" {

    subnet_id      = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public.id

  
}
# Private

resource "aws_route_table" "private" {

    vpc_id             = aws_vpc.vpc_main.id

    route {
        nat_gateway_id = aws_nat_gateway.natgw.id
        cidr_block     = "0.0.0.0/0"
    }

    tags               = {
    Name               = "Private Route Table"
    }
  
}

resource "aws_route_table_association" "private3" {

    subnet_id      = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private.id

}

resource "aws_route_table_association" "private4" {

    subnet_id      = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private.id
  
}



