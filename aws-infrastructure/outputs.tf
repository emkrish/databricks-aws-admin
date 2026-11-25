
output "aws_region" {
  description = "AWS deployment region"
  value       = data.aws_region.current.region
}

output "aws_account_id" {
  description = "Authenticated AWS account"
  value       = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  description = "Created VPC ID"
  value       = aws_vpc.databricks_vpc.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.databricks_vpc.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = {
    for name, subnet in aws_subnet.public :
    name => subnet.id
  }
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value = {
    for name, subnet in aws_subnet.private :
    name => subnet.id
  }
}


output "s3_bucket_name" {
  description = "Databricks lab S3 bucket name"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "Databricks lab S3 bucket ARN"
  value       = module.s3.bucket_arn
}

output "iam_policy_arn" {
  description = "IAM S3 access policy ARN"
  value       = module.iam.policy_arn
}

output "iam_policy_name" {
  description = "IAM S3 access policy name"
  value       = module.iam.policy_name
}
