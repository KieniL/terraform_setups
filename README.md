# terraform_setups

each own terraform setup contains a Makefile with two targets (test, doc)
Test runs terraform fmt, terraform validate, tflint, tfsec and checkov
doc runs terraform fmt, terraform-docs, inframap

You only need to include this in readme
```text
![Alt text](./graph.svg)
```