variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "action_group_webhooks" {
  description = "Map of Webhooks to notify. Example: `{ PagerDuty = 'https://events.pagerduty.com/integration/abcdefgh12345azerty/enqueue' }`"
  type        = map(string)
  default     = {}
}

variable "action_group_emails" {
  description = "Map of Emails to notify. Example: `{ ml-devops = devops@contoso.com }`"
  type        = map(string)
  default     = {}
}

variable "activity_log_alerts" {
  description = "Map of Activity log Alerts"
  type        = any
  default     = {}
}

variable "service_health" {
  description = <<EOD
A block supports the following: `events`, `locations` and `services`. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert"
```
{
  events    = "Incident"
  locations = "Global"
  service   = null
}
```
EOD
  type        = map(string)
  default     = null
}
