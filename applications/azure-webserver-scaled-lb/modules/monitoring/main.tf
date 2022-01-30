resource "azurerm_monitor_autoscale_setting" "autoscaler" {
  name                = "${var.project}-autoscaling"
  location            = var.location
  resource_group_name = var.resourcegroupname
  target_resource_id  = var.scaleset.id

  profile {
    name = "defaultProfile"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.scaleset.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.scaleset.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  tags = var.tags

}

resource "azurerm_log_analytics_workspace" "gatewayloganalyticsworkspace" {
  name                = "${var.project}-gateway-loganalyticsworkspace"
  location            = var.location
  resource_group_name = var.resourcegroupname
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "gatewaydiagnosticsettings" {
  name                       = "${var.project}-diagnosticsettings"
  target_resource_id         = var.appgateway.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.gatewayloganalyticsworkspace.id

  log {
    category = "ApplicationGatewayAccessLog"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "ApplicationGatewayPerformanceLog"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "ApplicationGatewayFirewallLog"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }
}