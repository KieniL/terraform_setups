terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = "eu-central-1"
}

resource "aws_lambda_function" "dynamo_lambda" {
  filename      = "dynamo-function.zip"
  function_name = "${terraform.workspace}-${var.dynamoFunctionName}"
  role          = aws_iam_role.iam_for_dynamolambda.arn
  memory_size   = 384
  handler       = "lambda_function.lambda_handler"
  depends_on = [
    aws_cloudwatch_log_group.dynamo_log,
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("dynamo-function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      tableName = "${terraform.workspace}-${var.tableName}",
      region    = var.region,
      queueName = "${terraform.workspace}-${var.queueName}"
    }
  }
  tags = {
    project     = var.projectTagValue
    environment = terraform.workspace
  }
}