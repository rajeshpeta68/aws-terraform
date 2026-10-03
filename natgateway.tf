resource "aws_eip" "nat_eip_1" {
    domain = "vpc"
    tags = {
        Name = "test-nat-eip-1"
    }
  
}


resource "aws_nat_gateway" "nat-gateway-1" {
    allocation_id = aws_eip.nat_eip_1.id
    subnet_id = aws_subnet.public_main_1.id

    tags = {
        Name = "test-nat-gateway-1"
    }
    depends_on = [ aws_internet_gateway.main-igw ]
  
}

resource "aws_eip" "nat_eip_2" {
    domain = "vpc"

    tags = {
        Name = "test-nat-eip-2"
    }
  
}


resource "aws_nat_gateway" "nat-gateway-2" {
    allocation_id = aws_eip.nat_eip_2.id
    subnet_id = aws_subnet.public_main_2.id

    tags = {
        Name = "test-nat-gateway-2"
    }
    depends_on = [ aws_internet_gateway.main-igw ]
  
}

