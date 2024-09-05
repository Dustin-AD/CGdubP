output "jump_box_public_ip" {
  description = "The public IP of the Jump Box"
  value       = aws_eip.jump_box_eip.public_ip
}
