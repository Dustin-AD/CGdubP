output "gpu_instance_public_ip" {
  value = aws_instance.gpu_instance.public_ip
}

output "gpu_eip" {
  value = aws_eip.gpu_eip.public_ip
}
