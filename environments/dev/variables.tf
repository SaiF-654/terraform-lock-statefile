variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets_cidrs" {
  description = "Public subnets CIDR list"
  type        = list(string)
}

variable "private_subnets_cidrs" {
  description = "Private subnets CIDR list"
  type        = list(string)
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}
