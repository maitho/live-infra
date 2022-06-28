

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Extract out common variables for reuse
  env            = local.environment_vars.locals.environment
  aws_region     = local.region_vars.locals.aws_region
  aws_account_id = local.account_vars.locals.aws_account_id

  # Common variables for reuse
  repo_owner  = "maitho"
  repo_name   = "login-app"
  repo_branch = "develop"
  repo_token  = "/devops/CodeRepoOauthToken"
}

terraform {
  source = "git::git@github.com:maitho/terraform-infra.git//pipelines/login-app?ref=v0.0.1"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  env            = local.env
  aws_account_id = local.aws_account_id
  aws_region     = local.aws_region

  CodeRepoOauthToken  = "${local.repo_token}"
  github_organization = "${local.repo_owner}"
  CodeRepoOwner       = "${local.repo_owner}"

  StackName      = "pipelines-${local.repo_name}"
  CodeRepoURL    = "https://github.com/${local.repo_owner}/${local.repo_name}"
  CodeRepoName   = "${local.repo_name}"
  CodeRepoBranch = "${local.repo_branch}"
  CodeRepoTag    = "0.0.1"
  image_tag      = "latest"
  create_ecr     = true
  compute_type   = "BUILD_GENERAL1_MEDIUM"
  environment_variables = [
    {
      env_name  = "DEPLOY_ENV"
      env_value = "${local.env}"
    },
    {
      env_name  = "AWS_DEFAULT_REGION"
      env_value = "${local.aws_region}"
    },
    {
      env_name  = "AWS_ACCOUNT_ID"
      env_value = "${local.aws_account_id}"
    },
    {
      env_name  = "REPOSITORY_URI"
      env_value = "/apps/login-app/ecr-repository"
    }
  ]
}
