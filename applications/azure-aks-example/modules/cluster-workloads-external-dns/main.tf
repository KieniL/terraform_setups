/*
* # externaldns on aks deployment
* Is needed to provision dns entries from ingresses
* ![Diagram](./graph.svg)
*/

data "azurerm_client_config" "current" {}

locals {
  external_dns_vars = {
    resource_group  = var.resourcegroupname,
    tenant_id       = data.azurerm_client_config.current.tenant_id,
    subscription_id = data.azurerm_client_config.current.subscription_id,
    log_level       = "debug",
    domain          = var.domainname
  }

  external_dns_values = templatefile(
    "${path.module}/templates/external_dns_values.yaml.tmpl",
    local.external_dns_vars
  )
}

resource "helm_release" "external_dns" {
  name             = "external-dns"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  namespace        = var.dns_namespace
  create_namespace = true
  version          = "5.4.5"
  values           = [local.external_dns_values]
}