provider "aws" {
  region = "us-east-1"
}

module "Network" {
  source                   = "../../Modules/Network"
  vpc_cidr_block           = "10.0.0.0/16"
  public_subnet1_cidr      = "10.0.1.0/24"
  private_app_subnet1_cidr = "10.0.3.0/24"
  private_app_subnet2_cidr = "10.0.4.0/24"
  public_route_table_cidr  = "0.0.0.0/0"
  availability_zone1       = "us-east-1a"
  availability_zone2       = "us-east-1b"
  vpc_name                 = "cgdubp_vpc"
  local_ip                 = var.local_ip
}

data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "gpu_instance" {
  ami               = data.aws_ami.windows.id
  instance_type     = "g4dn.xlarge"
  subnet_id         = module.Network.private_app_subnet1_id
  key_name          = var.key_name
  ipv6_address_count = 1
  security_groups    = [module.Network.app_sg_id]

  root_block_device {
    volume_size           = 200
    volume_type           = "gp2"
    delete_on_termination = false
  }

  tags = {
    Name = "${var.vpc_name}_GPU_Instance"
  }
}

resource "aws_db_instance" "cgdb" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.11"
  instance_class         = "db.t3.micro"
  db_name                = "cgdb"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres13"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  backup_retention_period = 7
  backup_window          = "07:00-09:00"
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}

resource "aws_dynamodb_table" "game_logs" {
  name     = "GameLogs"
  hash_key = "session_id"

  attribute {
    name = "session_id"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name        = "CGdubP-Logs"
    Environment = "production"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Security group for CGdubP RDS"
  vpc_id      = module.Network.vpc_id

  ingress {
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    ipv6_cidr_blocks = ["${var.local_ip}/128"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "cgdb-subnet-group"
  subnet_ids = [
    module.Network.private_app_subnet1_id,
    module.Network.private_app_subnet2_id
  ]

  tags = {
    Name = "CGdubP-RDS-Subnet-Group"
  }
}
