# Unit Tests — Route53 Alias Record Molecule
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run one test:     terraform test -test-directory=tests/unit -run "creates_when_enabled"
#
# Assertions target plan-KNOWN values only (tf-label id, input pass-throughs,
# the `enabled` flag). Computed attributes like fqdn/name resolve to unknown
# values under a mock provider, so they are not asserted on at plan time.

mock_provider "aws" {}

variables {
  # tf-label identity inputs
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module's own required inputs — valid-looking sample values
  zone_id                = "Z1234567890ABCDEFGHIJ"
  record_name            = "app.example.com"
  alias_name             = "my-alb-1234567890.eu-west-1.elb.amazonaws.com"
  alias_zone_id          = "Z32O12XQLNTSW2"
  evaluate_target_health = true
}

# ---------------------------------------------------------------------------
# Test: module is enabled by default and reports so
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default and expose enabled = true."
  }

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should be composed as namespace-stage-name (eg-test-thing)."
  }

  assert {
    condition     = module.record.enabled == true
    error_message = "The underlying record atom should also be enabled when the molecule is enabled."
  }
}

# ---------------------------------------------------------------------------
# Test: disabling the module creates nothing
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "When enabled = false, the module should report enabled = false."
  }
}
