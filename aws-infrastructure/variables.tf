
variable "project_name" {
  description = "Project name"
  type        = string
  default     = "databricks-admin-lab"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.20.0.0/16"
}

variable "common_tags" {
  description = "Common AWS resource tags"
  type        = map(string)

  default = {
    Project     = "Databricks-Admin-Lab"
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
