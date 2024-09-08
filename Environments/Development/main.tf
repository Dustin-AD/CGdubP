provider "aws" {
    region = "us-east-1"
}


# Module for Network
module "Network" {
    source = "../../Modules/Network"

  vpc_cidr_block         = "10.0.0.0/16"
  public_subnet1_cidr    = "10.0.1.0/24"
  private_app_subnet1_cidr = "10.0.3.0/24"
  public_route_table_cidr = "0.0.0.0/0"
  availability_zone1     = "us-east-1a" 
  vpc_name               = "cgdubp_vpc"
  public_ip              = var.public_ip
  local_ip               = var.local_ip

}



data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]  # You can change the vedrsion here if needed
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "gpu_instance" {
  ami                         = data.aws_ami.windows.id
  instance_type               = "g4dn.xlarge"
  subnet_id                   = module.Network.private_app_subnet1_id
  key_name                    = "bastion"

  security_groups             = [module.Network.app_sg_id] 

  tags = {
    Name = "${var.vpc_name}_GPU_Instance"
  }
}



resource "aws_eip" "gpu_eip" {
  instance                    = aws_instance.gpu_instance.id
  domain                      = "vpc"

  tags = {
    Name = "${var.vpc_name}_GPU_EIP"
  }
}