resource "aws_s3_bucket" "frontendstorage" {
  bucket = "${terraform.workspace}-${var.bucket_name}"
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
    {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${terraform.workspace}-${var.bucket_name}/*"
    }
	]
}
  EOF

  acl = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
  }

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

# data "archive_file" "frontend" {
#   type        = "zip"
#   source_dir  = "${path.module}/frontendcode"
#   output_path = "${path.module}/frontendcode.zip"
# }

# resource "aws_s3_bucket_object" "frontendcode" {
#   bucket = aws_s3_bucket.frontendstorage.id

#   key    = "frontendcode.zip"
#   source = data.archive_file.frontend.output_path

#   etag = filemd5(data.archive_file.frontend.output_path)

#   tags = {
#     project     = var.project
#     environment = terraform.workspace
#   }
# }
