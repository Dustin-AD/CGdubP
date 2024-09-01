provider "aws" {
    region = "us-east-1"
}



# Create a VPC
resource "aws_vpc" "GamingConsole_VPC" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "GamingConsole_VPC"
        Environment = "Dev"
        Project = "GamingConsole"
        Owner = "PrimaryAdmin"
        
    }
}



# Public Subnet 1
resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "GamingConsole_Public_Subnet1"
    }
}

# Public Subnet 2 in Development
resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "GamingConsole_Public_Subnet2"
    }
}


# Private Application Subnet 1
resource "aws_subnet" "private_app_subnet1" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "GamingConsole_Private_Subnet1"
    }
}


# Private Application Subnet 2
resource "aws_subnet" "private_app_subnet2" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "GamingConsole_Private_Subnet2"
    }
}



# Private Database Subnet 1
resource "aws_subnet" "private_db_subnet1" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "GamingConsole_Private_Subnet3"
    }
}



# Private Database Subnet 2
resource "aws_subnet" "private_db_subnet2" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "GamingConsole_Private_Subnet4"
    }
}



# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.GamingConsole_VPC.id

    tags = {
        Name = "GamingConsole_Internet_Gateway"
    }
}



# Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.GamingConsole_VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = "GamingConsole_Public_Route_Table"
    }
}



# Associate Public Subnet 1 with Public Route Table
resource "aws_route_table_association" "public_subnet1_association" {
    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.public_route_table.id
}



# Associate Public Subnet 2 with Public Route Table
resource "aws_route_table_association" "public_subnet2_association" {
    subnet_id = aws_subnet.public_subnet2.id
    route_table_id = aws_route_table.public_route_table.id
}
