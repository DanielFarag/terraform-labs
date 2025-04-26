data "aws_iam_policy_document" "lambda_assume_role_policy"{
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]   
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {  
  name = "lambda-role"  
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}


data "archive_file" "python_lambda_function" {  
  type = "zip"  
  source_file = "${path.module}/lambda_function.py" 
  output_path = "hello.zip"
}


resource "aws_lambda_function" "test_lambda_function" {
  function_name     = "hello_world"
  filename          = "hello.zip"
  source_code_hash  = data.archive_file.python_lambda_function.output_base64sha256
  role              = aws_iam_role.lambda_role.arn
  runtime           = "python3.13"
  handler           = "lambda_function.lambda_handler"
  timeout           = 10
}