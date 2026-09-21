terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}

# Security group allowing SSH access
resource "aws_security_group" "server_sg" {
  name        = "${var.project_name}-server-sg"
  description = "Security group for servers allowing SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-server-sg"
  }
}

# Create 4 Amazon Linux instances distributed across subnets
resource "aws_instance" "amazon_linux_servers" {
  count = var.amazon_linux_count

  ami                    = var.amazon_linux_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.server_sg.id]
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              hostnamectl set-hostname amazon-linux-${count.index + 1}
              # Install common utilities
              yum install -y git curl wget unzip
              EOF

  tags = {
    Name = "${var.project_name}-amazon-linux-${count.index + 1}"
    OS   = "Amazon-Linux"
    Type = "Amazon-Linux"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
    encrypted   = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create 6 Ubuntu instances distributed across subnets
resource "aws_instance" "ubuntu_servers" {
  count = var.ubuntu_count

  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.server_sg.id]
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              hostnamectl set-hostname ubuntu-${count.index + 1}
              # Install common utilities
              apt-get install -y git curl wget unzip
              EOF

  tags = {
    Name = "${var.project_name}-ubuntu-${count.index + 1}"
    OS   = "Ubuntu"
    Type = "Ubuntu"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
    encrypted   = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Elastic IP for Amazon Linux servers (first two)
resource "aws_eip" "amazon_linux_eip" {
  count    = min(2, var.amazon_linux_count)
  domain   = "vpc"
  instance = aws_instance.amazon_linux_servers[count.index].id

  tags = {
    Name = "${var.project_name}-amazon-linux-eip-${count.index + 1}"
  }
}

# Elastic IP for Ubuntu servers (first two)
resource "aws_eip" "ubuntu_eip" {
  count    = min(2, var.ubuntu_count)
  domain   = "vpc"
  instance = aws_instance.ubuntu_servers[count.index].id

  tags = {
    Name = "${var.project_name}-ubuntu-eip-${count.index + 1}"
  }
}