locals {
  gatewayname           = "${var.project}-appgateway"
  gateway_ip_config     = "${var.project}-gateway-ip-configuration"
  frontend_port_name    = "${var.project}-frontendportname"
  frontend_ip_config    = "${var.project}-frontendipconfig"
  backend_pool          = "${var.project}-backendpool"
  backend_http_settings = "${var.project}-httpsettings"
  backend_http_listener = "${var.project}-httplistener"
  request_routing_rule  = "${var.project}-requestroutingrule"
}