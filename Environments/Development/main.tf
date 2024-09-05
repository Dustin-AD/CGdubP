provider "aws" {
    region = "us-east-1"
}


# Module for Network
module "Network" {
    source = "../../Modules/Network"

  vpc_cidr_block         = "10.0.0.0/16"
  public_subnet1_cidr    = "10.0.1.0/24"
  public_subnet2_cidr    = "10.0.2.0/24"
  private_app_subnet1_cidr = "10.0.3.0/24"
  private_app_subnet2_cidr = "10.0.4.0/24"
  private_db_subnet1_cidr = "10.0.5.0/24"
  private_db_subnet2_cidr = "10.0.6.0/24"
  public_route_table_cidr = "0.0.0.0/0"
  availability_zone1     = "us-east-1a"  
  availability_zone2     = "us-east-1b"  
  vpc_name               = "cgdubp_vpc"
  public_ip              = var.public_ip
  local_ip               = var.local_ip

}



data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]  # You can change the version here if needed
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_instance" "jump_box" {
  ami                         = data.aws_ami.windows.id  # Replace with a valid AMI ID
  instance_type               = "t2.micro"    # Or another appropriate instance type
  subnet_id                   = module.Network.public_subnet1_id
  key_name                    = "bastion"  # Make sure to have an SSH key pair set up
  associate_public_ip_address = true  # This ensures the instance gets a public IP

  security_groups             = [module.Network.bastion_sg_id]  # Associate with the Bastion Host security group

  tags = {
    Name = "${var.vpc_name}_Jump_Box"
  }
}



resource "aws_eip" "jump_box_eip" {
  instance = aws_instance.jump_box.id
 domain = "vpc"
}
