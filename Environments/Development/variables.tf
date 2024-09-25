variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "local_ip" {
  description = "The local IP address that is allowed to access the GPU instance"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for instances"
  type        = string
}

variable "db_username" {
  description = "The database username"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}
