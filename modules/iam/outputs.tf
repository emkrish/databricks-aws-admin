
output "policy_arn" {
  description = "Created IAM policy ARN"
  value       = aws_iam_policy.s3_access.arn
}

output "policy_name" {
  description = "Created IAM policy name"
  value       = aws_iam_policy.s3_access.name
}
