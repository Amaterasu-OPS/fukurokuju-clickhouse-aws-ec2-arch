include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/ec2/asg"
}

dependency "lt" {
  config_path = "./lt"

  mock_outputs = {
    id = "lt-1234567890abcdef0"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  desired_capacity   = include.root.locals.config.cluster.node.count
  max_size           = include.root.locals.config.cluster.node.count
  min_size           = include.root.locals.config.cluster.node.count
  region             = include.root.locals.config.aws.region
  zones              = ["a"]
  launch_template_id = dependency.lt.outputs.id
}