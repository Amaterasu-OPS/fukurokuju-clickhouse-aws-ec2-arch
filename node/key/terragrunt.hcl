include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.modules}/modules/ec2/key"
}

inputs = {
  pk_file_path = "${include.root.locals.basePath}/${include.root.locals.config.cluster.name}.pem"
}