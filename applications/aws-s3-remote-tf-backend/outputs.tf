output "bucketname" {
  description = "the name of the bucket for the state storage"
  value       = module.s3.bucketname
}

output "statelock_id" {
  description = "The id of the state lock dynamotable"
  value       = module.dynamodb.statelock_id
}