# ----------------------------
# Security Groups
# ----------------------------

# Public EC2 SG (Bastion Host)
resource "aws_security_group" "public_ec2_sg" {
  name        = "public-ec2-sg-${var.environment}"
  description = "Allow SSH and HTTP from internet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name        = "public-ec2-sg-${var.environment}"
    Environment = var.environment
  }
}

# Private EC2 SG
resource "aws_security_group" "private_ec2_sg" {
  name        = "private-ec2-sg-${var.environment}"
  description = "Allow SSH only from bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2_sg.id]  # Only from bastion
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Internet via NAT Gateway
  }

  tags = {
    Name        = "private-ec2-sg-${var.environment}"
    Environment = var.environment
  }
}

# ----------------------------
# Public EC2 (Bastion Host)
# ----------------------------
resource "aws_instance" "public_ec2" {
  count         = var.public_instance_count
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.public_ec2_sg.id]

  tags = {
    Name        = "bastion-public-ec2-${count.index + 1}-${var.environment}"
    Environment = var.environment
  }
}

# ----------------------------
# Private EC2
# ----------------------------
resource "aws_instance" "private_ec2" {
  count         = var.private_instance_count
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  key_name      = var.key_name
  associate_public_ip_address = false  # No public IP
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id]

  tags = {
    Name        = "private-ec2-${count.index + 1}-${var.environment}"
    Environment = var.environment
  }
}

