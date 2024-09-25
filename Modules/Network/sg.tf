resource "aws_security_group" "app_sg" {
  name          = "${var.vpc_name}_App_SG"
  description   = "Security group for GPU instance"
  vpc_id        = aws_vpc.cgdubp_vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    ipv6_cidr_blocks = ["${var.local_ip}/128"] 
  }

egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.vpc_name}_App_SG"
  }
}