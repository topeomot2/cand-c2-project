provider "aws" {
  region  = "${var.aws_region}"
  profile = "default"
}

resource "aws_iam_role" "iam_for_lambda" {    
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
}

resource "aws_lambda_function" "udacity_lambda" {
  function_name = "udacity_greet_lambda"
  filename      = "udacity.zip"
  role          = aws_iam_role.iam_for_lambda.arn
  handler = "greet_lambda.lambda_handler"
  

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("udacity.zip")

  runtime = "python3.7"
  
}