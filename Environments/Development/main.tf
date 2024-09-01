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