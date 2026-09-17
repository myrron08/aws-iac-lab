output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "ec2_public_ip" {
  description = "EC2 public IP address"
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "NGINX test page URL"
  value       = "http://${aws_instance.web.public_ip}"
}
output "rds_endpoint" {
  description = "Private PostgreSQL endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_master_secret_arn" {
  description = "ARN of the Secrets Manager secret with RDS credentials"
  value       = try(aws_db_instance.postgres.master_user_secret[0].secret_arn, null)
  sensitive   = true
}
output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.main.function_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.main.arn
}
output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app.repository_url
}