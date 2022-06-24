# Intro

Using Terragrunt which is a thin terraform <b>wrapper</b> providing extra tools to keep the <b>backend</b> configuration DRY and used to execute terraffrom commands on <b>multiple modules</b> at once

This doc demonstrates the ETL process employed on PuttyLog data from field devices in aggregating and filtering for specific device

## Resources:
- [Terragrunt](https://terragrunt.gruntwork.io/)

## Terragrunt Installation

- Windows: using chocolatey: `choco install teragrunt`
- macOS: using HomeB=brew: `brew install terragrunt`
- Linux: using Homebrew: `brew install terragrunt`

To use terragrunt, terrafom is required to be installed:

- macOS: using Homebrew: `brew tap hashicorp/tap && brew tap hashicorp/tap && brew update`
- Winddows: using Chilolatey: `choco install terraform`
- Linux: Using using official HashiCorp singed packages available for the Linux distributions

This setup has been tested and run using Terragrunt Version `v0.36.7`

## Using Terragrunt commands to define create the Infrastructure

Instead of using `terraform` command directly, we will run the same commands with `terragrunt` which will forward almost all commands, arguments and options directlyy to terrafrom based on tge settigns on the `terragrunt.hcl` file. Se below commands

- terragrunt plan
- terragrunt apply
- terragrunt output
- terragrunt destroy

To create aws resource you will need the (terrafrom modules)[https://github.com/maitho/terraform-infra] source andith this setup, here is how to run terragrunt and create aws reource, a case with SSM paramters
` AWS_PROFILE=<aws-profile> terragrunt apply --terragrunt-source  /<path-to-terraform-modules>/terraform-infra//ssm/`
