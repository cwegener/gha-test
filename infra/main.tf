terraform {
  required_version = ">= 1.10.0"
}

variable "provider_token" {
  type = string
}

module "vpc" {
  source         = "../modules/vpc"
  provider_token = var.provider_token
}
