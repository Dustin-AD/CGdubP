variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_ip" {
  description = "The public IP of the jump box"
  type        = string
}

variable "local_ip" {
  description = "The local IP address that is allowed to access the Bastion Host"
  type        = string
}
