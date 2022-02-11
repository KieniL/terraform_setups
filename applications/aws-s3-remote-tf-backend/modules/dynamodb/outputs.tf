output "statelock_id" {
  description = "The id of the state lock dynamotable"
  value       = aws_dynamodb_table.lock-table.id
}