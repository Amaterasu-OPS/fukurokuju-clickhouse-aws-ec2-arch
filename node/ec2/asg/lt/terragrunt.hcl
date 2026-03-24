include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/ec2/lt"
}

dependency "ami" {
  config_path = "../../ami"

  mock_outputs = {
    id = "temp-ami-id"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

dependency "key" {
  config_path = "../../key"

  mock_outputs = {
    name = "temp-key"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

dependency "sg" {
  config_path = "../../sg"

  mock_outputs = {
    id = "temp-sg"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  ami_id             = dependency.ami.outputs.id
  instance_type      = include.root.locals.config.cluster.node.instance_type
  key_pair_name      = dependency.key.outputs.name
  user_data          = ""
  public_ip          = true
  security_group_ids = [dependency.sg.outputs.id]
  ebs_size           = include.root.locals.config.cluster.node.ebs_size
}