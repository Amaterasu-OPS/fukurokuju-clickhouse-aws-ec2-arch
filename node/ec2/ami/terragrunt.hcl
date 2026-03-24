include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/ec2/ami"
}

dependency "ec2" {
  config_path = "../"

  mock_outputs = {
    instance_id = "temp-instance-id"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  instance_id = dependency.ec2.outputs.instance_id
}