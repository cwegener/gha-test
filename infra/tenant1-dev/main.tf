terraform {
  required_version = ">= 1.10.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

variable "provider_token" {
  type = string
}

module "vpc" {
  # tflint-ignore: terraform_module_pinned_source
  source         = "github.com/cwegener/gha-test.git//modules/vpc?ref=master"
  provider_token = var.provider_token
}

resource "helm_release" "example" {
  name       = "my-redis-release"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "redis"
  version    = "7.4.2"
}
