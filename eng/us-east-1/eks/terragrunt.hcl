locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))


  # Extract out common variables for reuse
  env            = local.environment_vars.locals.environment
  aws_region     = local.region_vars.locals.aws_region
  aws_account_id = local.account_vars.locals.aws_account_id
}

terraform {
  source = "git::git@github.com:maitho/terraform-infra.git//eks?ref=v0.0.1"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  env                      = local.env
  region                   = local.aws_region
  availability_zones_count = 2
  project                  = "Jambo"
  vpc_cidr                 = "10.0.0.0/16"
  subnet_cidr_bits         = 8
}