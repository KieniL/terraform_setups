output "bucketname" {
  description = "the name of the bucket for the state storage"
  value       = module.s3.bucketname
}