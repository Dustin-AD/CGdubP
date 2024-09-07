# Create a VPC
resource "aws_vpc" "cgdubp_vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
        Name = var.vpc_name
        
    }
}



# Public Subnet 1
resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.cgdubp_vpc.id
    cidr_block = var.public_subnet1_cidr
    availability_zone = var.availability_zone1

    tags = {
        Name = "${var.vpc_name}_Public_Subnet1"
    }
}



# Private Application Subnet 1
resource "aws_subnet" "private_app_subnet1" {
    vpc_id = aws_vpc.cgdubp_vpc.id
    cidr_block = var.private_app_subnet1_cidr
    availability_zone = var.availability_zone1

    tags = {
        Name = "${var.vpc_name}_Private_Subnet1"
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

    tags = {
        Name = "${var.vpc_name}_Public_Route_Table"
    }
}



# Associate Public Subnet 1 with Public Route Table
resource "aws_route_table_association" "public_subnet1_association" {
    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.public_route_table.id
}