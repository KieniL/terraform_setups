
variable "resource" {
  description = "Resource parameters"
  default = {
    location    = "Germany West Central"
    project     = "azurecli-armtest"
    templateuri = "https://raw.githubusercontent.com/fortinet/fortiweb-ha/main/azure/templates/deploy_fwb_ha.json"
  }
}
