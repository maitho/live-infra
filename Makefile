profile=maitho
terragrunt-source=/Users/davidmaitho/Documents/Interviews/peach-payments/terraform-infra
root_dir = $(shell pwd)
working_dir = $(shell pwd)/eng/us-east-1

deploy-ssm:
	cd $(working_dir)/ssm && AWS_PROFILE=$(profile) terragrunt apply --terragrunt-source $(terragrunt-source)//ssm

deploy-pipeline:
	cd $(working_dir)/pipelines/login-app && AWS_PROFILE=$(profile) terragrunt apply --terragrunt-source $(terragrunt-source)//pipeline

deploy-eks:
	cd $(working_dir)/eks && AWS_PROFILE=$(profile) terragrunt apply --terragrunt-source $(terragrunt-source)//eks


destroy-ssm:
	cd $(working_dir)/ssm && AWS_PROFILE=$(profile) terragrunt destroy --terragrunt-source $(terragrunt-source)//ssm

destroy-pipeline:
	cd $(working_dir)/pipelines/login-app && AWS_PROFILE=$(profile) terragrunt destroy --terragrunt-source $(terragrunt-source)//pipeline

destroy-eks:
	cd $(working_dir)/eks && AWS_PROFILE=$(profile) terragrunt destroy --terragrunt-source $(terragrunt-source)//eks



deploy-all:
	cd $(working_dir)/ssm && AWS_PROFILE=$(profile) terragrunt apply --terragrunt-source $(terragrunt-source)//ssm $(option)
	cd $(working_dir)/pipelines/login-app && AWS_PROFILE=$(profile) terragrunt apply --terragrunt-source $(terragrunt-source)//pipeline $(option)
	cd $(working_dir)/eks && AWS_PROFILE=$(profile) terragrunt apply --terragrunt-source $(terragrunt-source)//eks $(option)

destroy-all:
	cd $(working_dir)/eks && AWS_PROFILE=$(profile) terragrunt destroy --terragrunt-source $(terragrunt-source)//eks $(option)
	cd $(working_dir)/pipelines/login-app && AWS_PROFILE=$(profile) terragrunt destroy --terragrunt-source $(terragrunt-source)//pipeline $(option)
	cd $(working_dir)/ssm && AWS_PROFILE=$(profile) terragrunt destroy --terragrunt-source $(terragrunt-source)//ssm $(option)