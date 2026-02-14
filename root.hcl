locals {
  aws_access_key = get_env("AWS_ACCESS_KEY_ID", "")
  aws_secret_key = get_env("AWS_SECRET_ACCESS_KEY", "")
  config         = yamldecode(file("${dirname(find_in_parent_folders("root.hcl"))}/configs/${get_env("CLUSTER_CONFIG", "cluster.yml")}"))
  modules        = "git::git@github.com:Amaterasu-OPS/artemis-terraform-modules.git/"
  basePath       = "${dirname(find_in_parent_folders("root.hcl"))}"
  cluster_type   = "clickhouse-ec2"
  common_hcl     = find_in_parent_folders("common.hcl")
  common         = read_terragrunt_config(local.common_hcl).locals.common_inputs
  inputs = {
    cluster_name          = local.config.cluster.name
    cluster_type          = local.cluster_type
    cluster_instance_type = local.common.cluster_instance_type
  }
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "${local.config.aws.s3.bucket}"
    key            = "${path_relative_to_include()}/terraform_${local.config.cluster.name}.tfstate"
    region         = "${local.config.aws.dynamodb.table_region}"
    dynamodb_table = "${local.config.aws.dynamodb.table_lock}"
    access_key     = "${local.aws_access_key}"
    secret_key     = "${local.aws_secret_key}"
    encrypt        = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      region = "${local.config.aws.region}"
      access_key = "${local.aws_access_key}"
      secret_key = "${local.aws_secret_key}"
    }
EOF
}

inputs = {
  cluster_name          = local.config.cluster.name
  cluster_type          = local.cluster_type
  cluster_instance_type = local.common.cluster_instance_type
  environment           = local.config.cluster.environment
}