include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:Amaterasu-OPS/artemis-terraform-modules.git//modules/ec2/key"
}

inputs = {
  cluster_name = "xpto"
  pk_file_path = "${get_terragrunt_dir()}/file.pem"
}