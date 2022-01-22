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
  name                = "${terraform.workspace}-iam-for-${var.lambda_function_name}"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

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

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

resource "aws_apigatewayv2_api" "itemsapi" {
  name          = "items-api"
  protocol_type = "HTTP"

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

resource "aws_apigatewayv2_stage" "gatewaystageprod" {
  api_id = aws_apigatewayv2_api.itemsapi.id

  name        = "prod"
  auto_deploy = true

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}

resource "aws_apigatewayv2_integration" "apiintegration" {
  api_id = aws_apigatewayv2_api.itemsapi.id

  integration_uri    = aws_lambda_function.lambda.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.itemsapi.name}"

  retention_in_days = 7

  tags = {
    project     = var.project
    environment = terraform.workspace
  }
}


# resource "aws_apigatewayv2_route" "hello_world" {
#   api_id = aws_apigatewayv2_api.lambda.id

#   route_key = "GET /hello"
#   target    = "integrations/${aws_apigatewayv2_integration.hello_world.id}"
# }

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.itemsapi.execution_arn}/*/*"
}