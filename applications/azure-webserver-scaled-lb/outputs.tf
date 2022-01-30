output "gateway_ip" {
  value = module.appgateway.gateway_ip
}

output "vnet_name" {
  value = module.vnet.vnet.name
}

output "vnet_resourcegroup" {
  value = module.vnet.vnet.resource_group_name
}