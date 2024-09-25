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
