data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.project_name}-${var.environment}-function"
  retention_in_days = 7
}

resource "aws_lambda_function" "main" {
  function_name = "${var.project_name}-${var.environment}-function"
  description   = "Lambda function created with Terraform"

  role    = aws_iam_role.lambda.arn
  handler = "index.lambda_handler"
  runtime = "python3.12"

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  memory_size = 128
  timeout     = 10

  vpc_config {
    subnet_ids         = aws_subnet.private[*].id
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      DB_HOST = aws_db_instance.postgres.address
      DB_PORT = tostring(aws_db_instance.postgres.port)
      DB_NAME = var.db_name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic,
    aws_iam_role_policy_attachment.lambda_vpc,
    aws_cloudwatch_log_group.lambda
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-function"
  }
}