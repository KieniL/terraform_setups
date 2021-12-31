test:
	terraform fmt
	terraform validate
	tflint
	tfsec --concise-output
	checkov -d ./ --compact --quiet
	
doc:
	terraform fmt
	terraform-docs markdown table --output-file README.md --output-mode inject ./
	inframap generate ./ --connections=false --raw | dot -Tsvg > graph.svg

	