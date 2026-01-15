variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID to launch EC2"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet ID to launch EC2"
}

variable "key_name" {
  type        = string
  description = "Key pair name for EC2 instances"
}

variable "public_instance_count" {
  type    = number
  default = 1
}

variable "private_instance_count" {
  type    = number
  default = 1
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
