terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/lambdacode"
  output_path = "${path.module}/lambdacode.zip"
}

resource "aws_lambda_function" "lambda" {
  filename      = "${path.module}/lambdacode.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  memory_size   = 384
  handler       = "index.handler"
  depends_on = [
    data.archive_file.lambda,
    aws_cloudwatch_log_group.lambda_loggroup,
  ]

  runtime = "nodejs12.x"

  environment {
    variables = {
      region = var.region,
    }
  }
  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

resource "aws_cloudwatch_log_group" "lambda_loggroup" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:DeleteItem",
        "dynamodb:Scan"
      ],
      "Resource": "${aws_dynamodb_table.product_table.arn}",
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn

}

#Role which retrieves the users from dynamodb and add to sqs
resource "aws_iam_role" "iam_for_lambda" {
  name = "${terraform.workspace}-iam-for-${var.lambda_function_name}"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
          "Action": "sts:AssumeRole",
          "Principal": {
              "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
      }
    ]
  }
  EOF
  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

resource "aws_dynamodb_table" "product_table" {
  name           = "${terraform.workspace}-${var.table_name}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "itemId"

  attribute {
    name = "itemId"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}