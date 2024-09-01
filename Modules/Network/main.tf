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



# Public Subnet 1 in Development
resource "aws_subnet" "dev_public_subnet1" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "GamingConsole_Dev_Public_Subnet1"
    }
}

# Public Subnet 2 in Development
resource "aws_subnet" "dev_public_subnet2" {
    vpc_id = aws_vpc.GamingConsole_VPC.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "GamingConsole_Dev_Public_Subnet2"
    }
}