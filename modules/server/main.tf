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

variable "vpc_name" {
  type = string
}

provider "fakewebservices" {
  token = var.provider_token
}

resource "fakewebservices_server" "servers" {
  count = 2

  name = "Server ${count.index + 1}"
  type = "t2.micro"
  vpc  = var.vpc_name
}
