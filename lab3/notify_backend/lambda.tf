

data "aws_iam_policy_document" "lambda_assume_role_policy" {
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


data "aws_iam_policy_document" "lambda_ses_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ObjectCreated",
      "ses:SendRawEmail",
      "ses:ListVerifiedEmailAddresses",
      "ses:SendTemplatedEmail"
    ]
    resources = ["*"]
  }
}


resource "aws_iam_role_policy" "lambda_ses" {
  name   = "lambda-ses-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_ses_policy.json
}


data "archive_file" "python_lambda_function" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/ses.zip"
}

resource "aws_lambda_function" "send_mail_onupdated_state" {
  function_name    = "ses"

  filename         = "${path.module}/ses.zip"
  source_code_hash = data.archive_file.python_lambda_function.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.13"
  handler          = "lambda_function.lambda_handler"
  timeout          = 10
  environment {
    variables = {
      SENDER_EMAIL      = var.ses_email_sender
      RECIPIENT_EMAILS  = join("|", var.s3_email_reciever)
    }
  }
}




resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket.arn
  function_name = aws_lambda_function.send_mail_onupdated_state.function_name
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.send_mail_onupdated_state.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".tfstate"
  }

  depends_on = [
    aws_lambda_function.send_mail_onupdated_state,
    aws_lambda_permission.allow_s3
  ]
}
