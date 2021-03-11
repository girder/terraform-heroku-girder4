output "public_ips" {
  value       = aws_eip.ec2_worker[*].public_ip
  description = "The public IP addresses of the EC2 workers."
}

output "iam_role_id" {
  value       = aws_iam_role.ec2_worker.id
  description = "The ID of the instance profile IAM role for the EC2 workers."
}
