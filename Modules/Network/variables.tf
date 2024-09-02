variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet1_cidr" {
  description = "The CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet2_cidr" {
  description = "The CIDR block for the second public subnet"
  type        = string
}

variable "private_app_subnet1_cidr" {
  description = "The CIDR block for the first private application subnet"
  type        = string
}

variable "private_app_subnet2_cidr" {
  description = "The CIDR block for the second private application subnet"
  type        = string
}

variable "private_db_subnet1_cidr" {
  description = "The CIDR block for the first private database subnet"
  type        = string
}

variable "private_db_subnet2_cidr" {
  description = "The CIDR block for the second private database subnet"
  type        = string
}

variable "public_route_table_cidr" {
  description = "The route table for the public subnets"
  type        = string
}

variable "availability_zone1" {
  description = "The first availability zone"
  type        = string
}

variable "availability_zone2" {
  description = "The second availability zone"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
