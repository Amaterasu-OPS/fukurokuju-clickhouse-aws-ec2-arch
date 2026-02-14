include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/ec2/sg"
}

dependency "ip" {
  config_path = "./ip"

  mock_outputs = {
    ip = "0.0.0.0"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  allowed_rules = [{
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    ip        = "${dependency.ip.outputs.ip}/32"
  }]
}