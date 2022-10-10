# Create Elastic IP Address
resource "aws_eip" "eip-ngw-01" {
    vpc = true

    tags = {
        Name = "EIP-01"
    }  
}

# Create Elastic IP Address-02
resource "aws_eip" "eip-ngw-02" {
    vpc = true

    tags = {
        Name = "EIP-02"
    }  
}

# Create NAT Gateway in public subnet-01
resource "aws_nat_gateway" "nat_gateway_01" {
    allocation_id = aws_eip.eip-ngw-01.id
    subnet_id = aws_subnet.public_subnet-1.id

    tags = {
        Name = "NGW-pub-sub-01"
    }
}


# Create NAT Gateway in public subnet-02
resource "aws_nat_gateway" "nat_gateway_02" {
    allocation_id = aws_eip.eip-ngw-02.id
    subnet_id = aws_subnet.public_subnet-2.id

    tags = {
        Name = "NGW-pub-sub-02"
    }
}

# Create Private Route Table-01 and Add Route Through Nat Gateway 01
resource "aws_route_table" "private_route_table-01" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_01.id
    }

    tags = {
      Name = "ngw-1-pvt-rt-01"
    }
}

# Associate Private Subnet-1 to Private Route Table -01
resource "aws_route_table_association" "pvt-sub-1-rt-1-assoc" {
    subnet_id =  aws_subnet.Priv-sub-01.id
    route_table_id = aws_route_table.private_route_table-01.id
}

# Create Private Route Table-02 and Add Route Through Nat Gateway 02
resource "aws_route_table" "private_route_table-02" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_02.id
    }

    tags = {
      Name = "ngw-2-pvt-rt-02"
    }
}

# Associate Private Subnet-1 to Private Route Table -01
resource "aws_route_table_association" "pvt-sub-2-rt-2-assoc" {
    subnet_id =  aws_subnet.Priv-sub-02.id
    route_table_id = aws_route_table.private_route_table-02.id
}