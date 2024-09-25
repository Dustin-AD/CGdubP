output "gpu_instance_ipv6" {
  value = aws_instance.gpu_instance.ipv6_addresses[0]
  description = "The IPv6 address of the GPU instance"
}