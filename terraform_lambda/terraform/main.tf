terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = var.region
}

resource "aws_iam_role" "iam_role_for_lambda" {
  name = var.iam_lambda_role

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

resource "aws_lambda_function" "mail_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = var.function_zip
  function_name = var.function_name
  role          = aws_iam_role.iam_role_for_lambda.arn
  handler       = var.handler

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.function_zip)

  runtime = var.runtime

  environment {
    variables = {
      MY_URL          = var.myurl
      EMAIL_ADDRESS   = var.sender
      EMAIL_PASSWORD  = var.passwd
      RECIPIENT_EMAIL = var.receiver
    }
  }
}
