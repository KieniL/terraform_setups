resource "aws_dynamodb_table" "lock-table" {
  name         = "tfstatelock-${var.random_string}"
  billing_mode = "PAY_PER_REQUEST" #since the lock table does not need to have always on capacity
  hash_key     = "LockID"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }
  tags = var.tags
}