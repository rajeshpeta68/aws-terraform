resource "aws_route_table" "public_main_1" {
    vpc_id = aws_vpc.main.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-igw.id
    }
    
    tags = {
        Name = "test-public-route-1"
    }
  
}

resource "aws_route_table_association" "public_main_1_route_association" {
    route_table_id = aws_route_table.public_main_1.id
    subnet_id = aws_subnet.public_main_1.id
  
}

resource "aws_route_table" "public_main_2" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-igw.id
    }

    tags = {
        Name = "test-public-route-2"
    }
  
}

resource "aws_route_table_association" "public_main_2_route_association" {
    route_table_id = aws_route_table.public_main_2.id
    subnet_id = aws_subnet.public_main_2.id
  
}

resource "aws_route_table" "private_main_1" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway-1.id
    }
  
}

resource "aws_route_table_association" "private_main_1_route_association" {
    route_table_id = aws_route_table.private_main_1.id
    subnet_id = aws_subnet.private_main_1.id
  
}

resource "aws_route_table" "private_main_2" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
    }
  
}

resource "aws_route_table_association" "private_main_2_route_association" {
    route_table_id = aws_route_table.private_main_2.id
    subnet_id = aws_subnet.private_main_2.id
  
}