include {
  path = find_in_parent_folders("root.hcl")
}

include "vars" {
  path   = "${get_terragrunt_dir()}/../vars/vars.hcl"
  expose = true
}

terraform {
  source = "${include.vars.locals.modules}/modules/ec2/key"
}

inputs = {
  cluster_name = "${include.vars.locals.config.cluster.name}"
  pk_file_path = "${get_terragrunt_dir()}/${include.vars.locals.config.cluster.name}.pem"
}