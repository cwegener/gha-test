terraform {
  required_version = ">= 1.10.0"
}

variable "provider_token" {
  type = string
}

variable = "unused" {
  default         = "slkgjlkfdg"      
}

module "vpc" {
  # tflint-ignore: terraform_module_pinned_source
  source         = "github.com/cwegener/gha-test.git//modules/vpc?ref=master"
  provider_token = var.provider_token
}
