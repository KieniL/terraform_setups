resource "azurerm_public_ip" "gatewayip" {
  name                = "${var.project}-gatewayip"
  location            = var.location
  resource_group_name = var.resourcegroupname
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_application_gateway" "appgateway" {
  name                = local.gatewayname
  location            = var.location
  resource_group_name = var.resourcegroupname

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 5
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_config
    subnet_id = var.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_config
    public_ip_address_id = azurerm_public_ip.gatewayip.id
  }

  backend_address_pool {
    name = local.backend_pool
  }

  backend_http_settings {
    name                  = local.backend_http_settings
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.backend_http_listener
    frontend_ip_configuration_name = local.frontend_ip_config
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule
    rule_type                  = "Basic"
    http_listener_name         = local.backend_http_listener
    backend_address_pool_name  = local.backend_pool
    backend_http_settings_name = local.backend_http_settings
  }

  tags = var.tags
}