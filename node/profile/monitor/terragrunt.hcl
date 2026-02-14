include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/iam/roles/monitor"
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
}