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
  source = "git::git@github.com:maitho/terraform-infra.git//ssm?ref=v0.0.1"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  env = local.env
  params = {
    ssm = [
      {
        "name" = "/eks/project-name"
        "paramValue" : "Jambo-cluster"
      },
      {
        "name" = "/devops/CodeRepoOauthToken"
        "paramValue" : "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"
      },
      {
        "name" : "/apps/login-app/ecr-repository"
        "paramValue" : "542279893489.dkr.ecr.us-east-1.amazonaws.com/login-app"
      },
    ]
  }
}