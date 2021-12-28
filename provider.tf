terraform {
  required_version = ">= 0.13"
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
    }
  }
}

provider "esxi" {
  esxi_hostname      = var.esxiHostname
  esxi_hostport      = var.esxiSSHPort
  esxi_hostssl       = var.esxiSSLPort
  esxi_username      = var.esxiUsername
  esxi_password      = var.esxiPassword
}
