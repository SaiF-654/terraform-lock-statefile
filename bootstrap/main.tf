# This file intentionally left simple — resources are split for readability
terraform {
  backend "local" {} # bootstrap uses local backend since S3 doesn’t exist yet
}
