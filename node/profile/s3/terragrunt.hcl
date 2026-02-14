include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/iam/roles/custom"
}

dependency "role" {
  config_path = "../role"

  mock_outputs = {
    name = "temp-role"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  ec2_role_name = dependency.role.outputs.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "VisualEditor0",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:DeleteObject",
          "ec2:DescribeInstances"
        ],
        Resource = "*"
      }
    ]
  })
}