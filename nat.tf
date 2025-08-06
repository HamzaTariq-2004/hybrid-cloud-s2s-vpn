resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
      Name = "HybridDR-NAT-EIP"
    }
}

# Creating NAT gateway in the public subnet
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet.id

    tags = {
      Name = "HybridDR-NAT"
    }

    depends_on = [aws_internet_gateway.igw]
}