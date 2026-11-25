
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
