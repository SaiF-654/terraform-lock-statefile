# Outputs modules/ec2/outputs.tf
output "public_ec2_ids" {
  value = aws_instance.public_ec2[*].id
}

output "private_ec2_ids" {
  value = aws_instance.private_ec2[*].id
}

output "public_ec2_sg_id" {
  value = aws_security_group.public_ec2_sg.id
}

output "private_ec2_sg_id" {
  value = aws_security_group.private_ec2_sg.id
}

output "public_ec2_ips" {
  value = aws_instance.public_ec2[*].public_ip
}
