locals {
  aws_region          = get_env("AWS_REGION", "us-east-1")
  aws_access_key      = get_env("AWS_ACCESS_KEY_ID", "")
  aws_secret_key      = get_env("AWS_SECRET_ACCESS_KEY", "")
  s3_bucket           = get_env("S3_BUCKET", "tf-results-bk")
  dynamodb_table_lock = get_env("DYNAMODB_TABLE_LOCK", "terraform-locks")
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "${local.s3_bucket}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.aws_region}"
    dynamodb_table = "${local.dynamodb_table_lock}"
    encrypt        = true
    access_key     = "${local.aws_access_key}"
    secret_key     = "${local.aws_secret_key}"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
        region = "${local.aws_region}"
        access_key = "${local.aws_access_key}"
        secret_key = "${local.aws_secret_key}"
    }
EOF
}
