test:
	terraform fmt
	terraform validate
	tflint
	tfsec --concise-output
	checkov -d ./ --compact --no-guide
	
doc:
	terraform fmt
	terraform-docs markdown table --output-file README.md --output-mode inject ./