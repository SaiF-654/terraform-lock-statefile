# environments/dev/outputs.tf

output "dev_vpc_id" {
  description = "VPC ID for dev environment"
  value       = module.vpc.vpc_id
}

output "dev_public_subnet_ids" {
  description = "Public subnet IDs for dev environment"
  value       = module.vpc.public_subnet_ids
}

output "dev_private_subnet_ids" {
  description = "Private subnet IDs for dev environment"
  value       = module.vpc.private_subnet_ids
}
