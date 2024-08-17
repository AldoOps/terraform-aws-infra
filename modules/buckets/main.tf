resource "aws_s3_bucket" "bucket_infra" {
  bucket = "aldo-curso-terraform"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket_infra.id
  versioning_configuration {
    status = "Enabled"
  }
}
  
output "bucket_id" {
  description = "ID da bucket criada na aws"
  value       = aws_s3_bucket.bucket_infra.id
}

output "bucket_arn" {
  description = "ARN da Bucket criada na Aws"
  value       = aws_s3_bucket.bucket_infra.id
}