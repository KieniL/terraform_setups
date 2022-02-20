test:
	terraform fmt --recursive
	terraform validate
	tflint
	tfsec --concise-output
	checkov -d ./ --compact --quiet


doc:
	terraform fmt --recursive
	terraform-docs markdown table --output-file README.md --output-mode inject  --recursive  --show all ./

SUBDIRS = modules/vnet modules/cluster modules/dns modules/cluster-workloads-awx modules/cluster-workloads-vault modules/cluster-workloads-external-dns 

graph:
	for dir in $(SUBDIRS); do \
        $(MAKE) -C $$dir graph; \
    done

plan:
	terraform fmt --recursive
	terraform plan -out plan.txt -var-file=terraform.tfvars

apply:
	terraform apply plan.txt