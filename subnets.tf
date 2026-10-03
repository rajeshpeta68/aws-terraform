resource "aws_subnet" "public_main_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-2a"

    tags = {
        Name = "test-public-subnet-a"
    }
}

resource "aws_subnet" "public_main_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-2b"

    tags = {
        Name = "test-public-subnet-b"
    }
}

resource "aws_subnet" "private_main_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "ap-south-2a"

    tags = {
        Name = "test-private-subnet-a"
    }  
}

resource "aws_subnet" "private_main_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.12.0/24"
    availability_zone = "ap-south-2b"

    tags = {
        Name = "test-private-subnet-b"
    }
  
}