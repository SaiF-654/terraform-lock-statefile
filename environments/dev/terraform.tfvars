# terraform.tfvars

region              = "us-east-1"
environment         = "dev"
vpc_cidr            = "10.0.0.0/16"
public_subnets_cidrs  = ["10.0.1.0/24"]
private_subnets_cidrs = ["10.0.101.0/24"]
key_name              = "my-ec2-key"