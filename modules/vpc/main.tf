data "aws_availability_zones" "zone" {}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "myvpc"
    Environment = var.environment
  }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.zone.names[count.index]

  tags = {
    Name        = "public-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnets_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.zone.names[count.index]

  tags = {
    Name        = "private-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  count  = length(var.public_subnets_cidrs)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "igw-${count.index + 1}"
    Environment = var.environment
  }
}

# NAT IPs
resource "aws_eip" "nat_ips" {
  count  = length(var.public_subnets_cidrs)
  domain = "vpc"

  tags = {
    Name        = "eip-${count.index + 1}"
    Environment = var.environment
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnets_cidrs)
  allocation_id = aws_eip.nat_ips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name        = "ngw-${count.index + 1}"
    Environment = var.environment
  }
}

# Public Route Tables
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.public_subnets_cidrs)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[count.index].id
  }

  tags = {
    Name        = "public-rt-${count.index + 1}"
    Environment = var.environment
  }
}

# Private Route Tables
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.private_subnets_cidrs)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name        = "private-rt-${count.index + 1}"
    Environment = var.environment
  }
}

# Route Table Associations
resource "aws_route_table_association" "public_ass" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt[count.index].id
}

resource "aws_route_table_association" "private_ass" {
  count          = length(var.private_subnets_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}
