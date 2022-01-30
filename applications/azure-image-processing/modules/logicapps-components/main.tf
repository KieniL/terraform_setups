resource "azurerm_app_service_plan" "logicappserviceplan" {
  name                = "${var.project}-logicapp-service-plan"
  location            = var.location
  resource_group_name = var.resourcegroupname

  sku {
    tier = "WorkflowStandard"
    size = "WS1"
  }

  tags = var.tags
}

resource "azurerm_application_insights" "appinsight" {
  name                = "${var.project}-logicapp-insights"
  location            = var.location
  resource_group_name = var.resourcegroupname
  application_type    = "other"
  retention_in_days   = 30

  workspace_id = azurerm_log_analytics_workspace.logicapploganalyticsworkspace.id

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "logicapploganalyticsworkspace" {
  name                = "${var.project}-logicapp-loganalyticsworkspace"
  location            = var.location
  resource_group_name = var.resourcegroupname
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "appinsightdiagnosticsettings" {
  name                       = "${var.project}-appinsightdiagnosticsettings"
  target_resource_id         = azurerm_application_insights.appinsight.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logicapploganalyticsworkspace.id

  log {
    category = "AppAvailabilityResults"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppBrowserTimings"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppEvents"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppDependencies"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppExceptions"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppPageViews"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppPerformanceCounters"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppRequests"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppSystemEvents"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AppTraces"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 3
    }
  }

  log {
    category = "AllMetrics"
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