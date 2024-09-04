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
  public_ip              = "192.168.0.8"
}
