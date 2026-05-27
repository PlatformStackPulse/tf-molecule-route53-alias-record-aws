output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "fqdn" {
  description = "FQDN of the record"
  value       = module.record.fqdn
}

output "name" {
  description = "Name of the record"
  value       = module.record.name
}
