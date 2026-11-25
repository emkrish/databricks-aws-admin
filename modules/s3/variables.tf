
variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "databricks-admin-lab-"
}

variable "tags" {
  description = "Tags applied to the S3 bucket"
  type        = map(string)
  default = {
    Project     = "Future-Unicorn"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}
