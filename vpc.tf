resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "HybridDR-VPC"
    }
}

# internet gateway for public subnet
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "HybridDR-IGW"
    }
}

# public subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"

    tags = {
      Name = "Public-Subnet"
    }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private-Subnet"
  }
}

# public route table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "Public Route Table"
    }
}

# Associate public route table with public subnet
resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

# private route table 
resource "aws_route_table" "private_rt" {   
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "Private Route Table"
    }
}

# private route
resource "aws_route" "private_to_internet" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block =  "0.0.0.0/0" # any traffic not in VPC/On-prem
  nat_gateway_id = aws_nat_gateway.nat.id # Goes out via NAT Gateway
}

# Associate Private Route table
resource "aws_route_table_association" "private_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}

# vgw route for on-prem to aws and vice versa
resource "aws_route" "private_to_onprem" {
    route_table_id = aws_route_table.private_rt.id
    destination_cidr_block = "192.168.100.0/24"
    gateway_id = aws_vpn_gateway.vgw.id
}