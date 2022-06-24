locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  assume_role  = local.account_vars.locals.assume_role
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
  env          = local.environment_vars.locals.environment
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  # version = "~> 2.0"
  region = "${local.aws_region}"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.account_id}"]
//   assume_role {
//     role_arn     = "${local.assume_role}"
//     session_name = "Terraform"
//   }
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${get_env("TG_BUCKET", "devops.${local.aws_region}.${local.env}.maitho.com")}"
    key            = "terraform-state/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "TerraformLocking"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}