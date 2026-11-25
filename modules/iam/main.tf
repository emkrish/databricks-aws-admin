
resource "aws_iam_policy" "s3_access" {
  name        = var.policy_name
  description = "Least privilege access to the Databricks lab S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid      = "AllowBucketListing"
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = var.bucket_arn
      },
      {
        Sid    = "AllowObjectReadWrite"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${var.bucket_arn}/*"
      }
    ]
  })

  tags = var.tags
}
