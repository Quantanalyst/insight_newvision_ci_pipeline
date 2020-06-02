variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

resource "random_pet" "this" {
  length = 2
}

variable "id" {
  type = string
  default = ""
}

locals {
  id = var.id == "" ? random_pet.this.id : var.id
}

module "network" {
  source = "github.com/insight-infrastructure/terraform-aws-network"
  id = local.id
}

module "defaults" {
  source = "../.."
  id = local.id
  vpc_id = module.network.vpc_id

  vpc_security_group_ids = module.network.security_group_id
  subnet_ids = module.network.private_subnets
}
