
output "bucket_url" {
  value = aws_s3_bucket.frontendstorage.bucket_domain_name
  description = "The url to the public bucket"
}