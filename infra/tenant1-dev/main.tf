terraform {
  required_version = ">= 1.10.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

resource "helm_release" "example" {
  name       = "my-redis-release"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "redis"
  version    = "20.9.0"
}
