resource "aws_security_group" "app_sg" {
  name        = "${var.vpc_name}_App_SG"
  description = "Security group for GPU instance"
  vpc_id      = aws_vpc.cgdubp_vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.local_ip}/32"]  # For RDP access from your local machine
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}_App_SG"
  }
}

