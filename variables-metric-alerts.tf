variable "metric_alerts" {
  description = "Map of metric Alerts"
  type = map(object({
    custom_name              = optional(string, null)
    scopes                   = optional(list(string), [])
    description              = optional(string, null)
    enabled                  = optional(bool, true)
    auto_mitigate            = optional(bool, true)
    severity                 = optional(number, 3)
    frequency                = optional(string, "PT5M")
    window_size              = optional(string, "PT5M")
    target_resource_type     = optional(string, null)
    target_resource_location = optional(string, null)

    criteria = object({
      metric_namespace       = optional(string)
      metric_name            = optional(string)
      aggregation            = optional(string)
      operator               = optional(string, "GreaterThan")
      threshold              = optional(number, 50)
      skip_metric_validation = optional(bool, false)
      dimension = optional(object({
        name     = string
        operator = optional(string, "Include")
        values   = list(any)
      }), null)
    })
  }))
  default = {}
}
