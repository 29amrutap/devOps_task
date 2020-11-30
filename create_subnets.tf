provider "google" {
  version = "~> 3.3.0"
}

provider "null" {
  version = "~> 2.1"
}

locals {
  subnet_01 = "${var.network_name}-bastion-01"
  subnet_02 = "${var.network_name}-frontend-02"
  subnet_03 = "${var.network_name}-backend-03"
}

module "vpc" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = local.subnet_01
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = local.subnet_02
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
    },
    {
      subnet_name           = local.subnet_03
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-west1"
    }

  ]
}

