
variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "bucket_arn" {
  description = "S3 bucket ARN to which access is restricted"
  type        = string
}

variable "tags" {
  description = "Tags for IAM resources"
  type        = map(string)

  default = {
    Project     = "Future-Unicorn"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}
