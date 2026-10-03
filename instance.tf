resource "aws_instance" "web_Public_1" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"

    subnet_id = aws_subnet.public_main_1.id
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]

    tags = {
        Name = "web-server-1"
    }
  
}

resource "aws_instance" "app_private_1" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"

    subnet_id = aws_subnet.private_main_1.id
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]

    tags = {
        Name = "app-server-1"
    }
  
}

resource "aws_instance" "web_public_2" {
    ami = data.aws_ami.amazon_linux.id
    subnet_id = aws_subnet.public_main_2.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]

    tags = {
        Name = "web-server-2"
    }
  
}

resource "aws_instance" "app_private_2" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private_main_2.id
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]

    tags = {
        Name = "app-server-2"
    }
  
}