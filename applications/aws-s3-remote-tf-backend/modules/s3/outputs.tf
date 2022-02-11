output "bucketname" {
  description = "the name of the bucket for the state storage"
  value       = aws_s3_bucket.statestorage.bucket_regional_domain_name
}