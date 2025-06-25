# Data sources for dynamic values

# Get current AWS region
data "aws_region" "current" {}

# Get current AWS caller identity (account ID)
data "aws_caller_identity" "current" {}

# Get available availability zones in current region
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
