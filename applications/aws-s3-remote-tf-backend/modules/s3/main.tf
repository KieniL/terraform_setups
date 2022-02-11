resource "random_string" "bucketname" {
  length    = 8
  special   = false
  lower     = true
  min_lower = 8 #force all characters to lowercase
}

resource "aws_s3_bucket" "statestorage" {
  bucket = "statebucket${random_string.bucketname.result}"
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "statestorage_acl" {
  bucket = aws_s3_bucket.statestorage.id
  acl    = "private"
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.statestorage.arn,
      "${aws_s3_bucket.statestorage.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.statestorage.id
  policy = data.aws_iam_policy_document.allow_access.json
}

resource "aws_s3_bucket_public_access_block" "blockpublic" {
  bucket = aws_s3_bucket.statestorage.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucketsse" {
  bucket = aws_s3_bucket.statestorage.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_state" {
  bucket = aws_s3_bucket.statestorage.id
  versioning_configuration {
    status = "Enabled"
    mfa_delete = "Enable"
  }
}