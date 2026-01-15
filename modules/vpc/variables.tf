variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidrs" {
  description = "Public subnets CIDR list"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidrs" {
  description = "Private subnets CIDR list"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}
