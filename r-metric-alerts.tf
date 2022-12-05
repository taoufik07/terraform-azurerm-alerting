resource "azurerm_monitor_metric_alert" "metric_alert" {
  for_each = var.metric_alerts

  name                = lookup(each.value, "custom_name", data.azurecaf_name.metric_alert[each.key].result)
  resource_group_name = lookup(each.value, "resource_group_name", var.resource_group_name)
  scopes              = each.value.scopes
  description         = each.value.description

  enabled       = lookup(each.value, "enabled", true)
  auto_mitigate = lookup(each.value, "auto_mitigate", true)
  severity      = lookup(each.value, "severity", 3)

  frequency   = lookup(each.value, "frequency", "PT5M")
  window_size = lookup(each.value, "window_size", "PT5M")

  target_resource_type     = lookup(each.value, "target_resource_type", null)
  target_resource_location = lookup(each.value, "target_resource_location", null)

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name

    aggregation = each.value.aggregation
    operator    = lookup(each.value, "operator", "GreaterThan")
    threshold   = lookup(each.value, "threshold", 50)

    skip_metric_validation = lookup(each.value, "skip_metric_validation", false)

    dynamic "dimension" {
      for_each = lookup(each.value, dimension, [])
      content {
        name     = each.value.dimension.name
        operator = lookup(each.value.dimension, "operator", "Include")
        values   = each.values.dimension.values
      }
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_notification.id

    webhook_properties = {
      from = "terraform"
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
