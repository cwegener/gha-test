terraform {
  required_version = ">= 1.10.0"
  required_providers {
    fakewebservices = {
      source  = "hashicorp/fakewebservices"
      version = "~> 0.1"
    }
  }
}

variable "provider_token" {
  type = string
}
provider "fakewebservices" {
  token = var.provider_token
}

resource "fakewebservices_vpc" "primary_vpc" {
  name       = "Primary VPC"
  cidr_block = "0.0.0.0/1"
}

output "vpc_name" {
  value = fakewebservices_vpc.primary_vpc.name
}
