test:
	terraform fmt
	terraform validate
	tflint
	tfsec --concise-output
	checkov -d ./ --compact --quiet
	
doc:
	terraform fmt
	terraform-docs markdown table --output-file README.md --output-mode inject ./

plan:
	terraform fmt
	terraform plan -out plan.txt -var-file=terraform.tfvars

apply:
	terraform apply plan.txt