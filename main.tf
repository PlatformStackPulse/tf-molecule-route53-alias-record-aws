# Molecule: Route53 Alias Record
module "record" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-route53-record-aws.git?ref=e83e2ca"

  context                = module.this.context
  zone_id                = var.zone_id
  record_name            = var.record_name
  record_type            = "A"
  is_alias               = true
  alias_name             = var.alias_name
  alias_zone_id          = var.alias_zone_id
  evaluate_target_health = var.evaluate_target_health
}
