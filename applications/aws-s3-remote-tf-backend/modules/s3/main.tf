data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "statestorage" {
  bucket = "tfstate-${var.random_string}"
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "statestorage_acl" {
  bucket = aws_s3_bucket.statestorage.id
  acl    = "private"
}

data "aws_iam_policy_document" "restrict_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.arn]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.statestorage.arn,
      "${aws_s3_bucket.statestorage.arn}/*",
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.arn]
    }

    not_actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.statestorage.arn,
      "${aws_s3_bucket.statestorage.arn}/*",
    ]

    condition {
      test     = "NumericGreaterThan"
      variable = "aws:MultiFactorAuthAge"

      values = [
        60,
      ]
    }
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.arn]
    }

    not_actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.statestorage.arn,
      "${aws_s3_bucket.statestorage.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        true,
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "restrict_access" {
  bucket = aws_s3_bucket.statestorage.id
  policy = data.aws_iam_policy_document.restrict_access.json
}

resource "aws_s3_bucket_public_access_block" "blockpublic" {
  bucket = aws_s3_bucket.statestorage.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
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
  }
}