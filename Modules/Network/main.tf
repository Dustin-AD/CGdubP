# Create a VPC
resource "aws_vpc" "cgdubp_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = true 

  tags = {
    Name = var.vpc_name
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.vpc_name}_NAT_EIP"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id  # Direct reference to public subnet

  tags = {
    Name = "${var.vpc_name}_NAT_Gateway"
  }
}

# Public Subnet 1
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.cgdubp_vpc.id
  cidr_block        = var.public_subnet1_cidr
  ipv6_cidr_block   = cidrsubnet(aws_vpc.cgdubp_vpc.ipv6_cidr_block, 8, 0)
  availability_zone = var.availability_zone1
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.vpc_name}_Public_Subnet1"
  }
}

# Private Application Subnet 1
resource "aws_subnet" "private_app_subnet1" {
  vpc_id            = aws_vpc.cgdubp_vpc.id
  cidr_block        = var.private_app_subnet1_cidr
  ipv6_cidr_block   = cidrsubnet(aws_vpc.cgdubp_vpc.ipv6_cidr_block, 8, 1)
  availability_zone = var.availability_zone1
   assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.vpc_name}_Private_Subnet1"
  }
}

# Private Application Subnet 2
resource "aws_subnet" "private_app_subnet2" {
  vpc_id            = aws_vpc.cgdubp_vpc.id
  cidr_block        = var.private_app_subnet2_cidr
  availability_zone = var.availability_zone2

  tags = {
    Name = "${var.vpc_name}-Private-Subnet2"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.cgdubp_vpc.id

  tags = {
    Name = "${var.vpc_name}_Internet_Gateway"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.cgdubp_vpc.id

  route {
    cidr_block = var.public_route_table_cidr
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
 
   route {
    ipv6_cidr_block = "::/0"  
    gateway_id      = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.vpc_name}_Public_Route_Table"
  }
}

# Route Table for Private Subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.cgdubp_vpc.id  # Use direct reference to the VPC

  tags = {
    Name = "${var.vpc_name}_Private_Route_Table"
  }
}

# Private Subnet Route for NAT Gateway
resource "aws_route" "private_subnet_route" {
  route_table_id         = aws_route_table.private_route_table.id  # Direct reference to the private route table
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Private Subnet Route for IPv6 (via Internet Gateway)
resource "aws_route" "private_subnet_ipv6_route" {
  route_table_id          = aws_route_table.private_route_table.id
  destination_ipv6_cidr_block = "::/0"  # Route all IPv6 traffic
  gateway_id              = aws_internet_gateway.internet_gateway.id
}

# Associate Public Subnet 1 with Public Route Table
resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id  # Direct reference to public subnet
  route_table_id = aws_route_table.public_route_table.id  # Direct reference to public route table
}

# Associate Private Subnet 1 with Private Route Table
resource "aws_route_table_association" "private_subnet1_assoc" {
  subnet_id      = aws_subnet.private_app_subnet1.id  # Direct reference to private subnet
  route_table_id = aws_route_table.private_route_table.id  # Direct reference to private route table
}
