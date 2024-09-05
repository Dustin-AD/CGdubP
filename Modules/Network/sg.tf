resource "aws_security_group" "bastion_sg" {
  name        = "${var.vpc_name}_Bastion_SG"
  description = "Security group for Bastion Host"
  vpc_id      = aws_vpc.cgdubp_vpc.id

  # Inbound rule to allow SSH access from your IP or a specific range
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.local_ip}/32"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}_Bastion_SG"
  }
}
