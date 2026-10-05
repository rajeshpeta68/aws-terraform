resource "aws_instance" "web_Public_1" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    associate_public_ip_address = true

    subnet_id = aws_subnet.public_main_1.id
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]
    key_name = "base"

    tags = {
        Name = "web-server-1"
    }

    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("${path.module}/base.pem")
        host = self.public_ip
    }

    provisioner "file" {
        source = "${path.module}/base.pem"
        destination = "/home/ec2-user/base.pem"
      
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chown ec2-user:ec2-user /home/ec2-user/base.pem",
            "sudo chmod 400 /home/ec2-user/base.pem"
        ]
      
    }
  
}

resource "aws_instance" "app_private_1" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"

    subnet_id = aws_subnet.private_main_1.id
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]
    key_name = "base"

    tags = {
        Name = "app-server-1"
    }
  
}

resource "aws_instance" "web_public_2" {
    ami = data.aws_ami.amazon_linux.id
    subnet_id = aws_subnet.public_main_2.id
    associate_public_ip_address = true
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]
    key_name = "base"

    tags = {
        Name = "web-server-2"
    }

    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("${path.module}/base.pem")
        host = self.public_ip
    }

    provisioner "file" {
        source = "${path.module}/base.pem"
        destination = "/home/ec2-user/base.pem"
      
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chown ec2-user:ec2-user /home/ec2-user/base.pem",
            "sudo chmod 400 /home/ec2-user/base.pem"
        ]
      
    }
  
}

resource "aws_instance" "app_private_2" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private_main_2.id
    vpc_security_group_ids = [ aws_security_group.main_web_sg.id ]
    key_name = "base"

    tags = {
        Name = "app-server-2"
    }
  
}