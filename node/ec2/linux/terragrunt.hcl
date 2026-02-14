include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/ec2/aws_linux"
}

inputs = {
  arch = "arm64"
}