resource "aws_instance" "private_ec2" { 
    ami = var.ec2_ami
    instance_type = var.ec2_instance_type
    subnet_id = aws_subnet.private_subnet.id
    associate_public_ip_address = false
    vpc_security_group_ids = [aws_security_group.private_ec2_sg.id]
    key_name = var.key_pair_name

    tags = {
      Name = "Private-EC2"
    }
}

resource "aws_security_group" "private_ec2_sg" {
    name = "PrivateEC2SG"
    description = "Allow on-prem access"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "SSH from on-prem"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["192.168.100.0/24"] #on-prem CIDR
    }

    ingress {
        description = "ICMP ping from on-prem"
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["192.168.100.0/24"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] # allow all outbound
    }

    tags = {
      Name = "Private_EC2_SG"
    }
}