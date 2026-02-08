locals {
  modules = "git::git@github.com:Amaterasu-OPS/artemis-terraform-modules.git/"
  config  = yamldecode(file("${dirname(find_in_parent_folders("root.hcl"))}/configs/${get_env("CLUSTER_CONFIG", "cluster.yml")}"))
}