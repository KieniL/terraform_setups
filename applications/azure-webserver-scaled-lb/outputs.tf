output "gateway_ip" {
  value = module.appgateway.gateway_ip.ip_address
}

output "vnet" {
  value = module.vnet.vnet
}
