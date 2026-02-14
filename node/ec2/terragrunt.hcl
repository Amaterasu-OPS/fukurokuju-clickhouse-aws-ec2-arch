include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/ec2/ec2"
}

dependency "key" {
  config_path = "../key"

  mock_outputs = {
    name = "temp-key"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

dependency "sg" {
  config_path = "../sg"

  mock_outputs = {
    id = "temp-sg"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

dependency "linux" {
  config_path = "../linux"

  mock_outputs = {
    id = "temp-ami"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

dependency "profile" {
  config_path = "../profile"

  mock_outputs = {
    name = "temp-profile"
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  instance_type        = include.root.locals.config.cluster.node.instance_type
  ami_id               = dependency.linux.outputs.id
  subnet_id            = ""
  key_name             = dependency.key.outputs.name
  public_ip            = true
  ebs_size             = include.root.locals.config.cluster.node.ebs_size
  iam_instance_profile = dependency.profile.outputs.name
  security_group_ids   = [dependency.sg.outputs.id]
}