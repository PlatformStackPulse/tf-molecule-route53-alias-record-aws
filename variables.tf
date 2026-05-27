variable "zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "record_name" {
  description = "DNS record name"
  type        = string
}

variable "alias_name" {
  description = "DNS name of the alias target (e.g., ALB DNS name)"
  type        = string
}

variable "alias_zone_id" {
  description = "Hosted zone ID of the alias target"
  type        = string
}

variable "evaluate_target_health" {
  description = "Whether to evaluate target health"
  type        = bool
  default     = true
}
