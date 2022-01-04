test:
	terraform fmt
	terraform validate
	tflint
	tfsec --concise-output
	checkov -d ./ --compact --quiet
	
doc:
	terraform fmt
	terraform-docs markdown table --output-file README.md --output-mode inject ./
	terraform graph -draw-cycles | dot -Tsvg > graph.svg

plan:
	terraform fmt
	terraform plan -out plan.txt

apply:
	terraform apply plan.txt