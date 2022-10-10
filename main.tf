# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc-tag-name}-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc-tag-name}-igw"
  }
}
# Create public subnet 01
resource "aws_subnet" "public_subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-1_CIDR
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc-tag-name}-pub_sub-1"
  }
}

# Create Public Subnet 02
resource "aws_subnet" "public_subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-2_CIDR
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc-tag-name}-pub_sub-2"
  }
}

# Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.vpc-tag-name}-pub-rt"
  }

}

# Associate public subnet 01 to public route table
resource "aws_route_table_association" "pub-sub-01-rt-assoc" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate public subnet 02 to public route table
resource "aws_route_table_association" "pub-sub-02-rt-assoc" {
  subnet_id      = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create Private Subnet 01
resource "aws_subnet" "Priv-sub-01" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.Private-subnet-1_CIDR
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc-tag-name}-pvt-sub-01"
  }
}

# Create Private Subnet 02
resource "aws_subnet" "Priv-sub-02" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.Private-subnet-2_CIDR
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc-tag-name}-pvt-sub-02"
  }
}