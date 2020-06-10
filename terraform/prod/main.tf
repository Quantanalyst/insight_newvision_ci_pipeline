provider "aws" {
  region = "us-west-2"  
}


module "my_vpc" {
  source = "../modules/vpc"
  vpc_cidr = "192.168.0.0/16"
  tenancy = "default"
  vpc_id = "${module.my_vpc.vpc_id}"
  subnet_cidr = "192.168.1.0/24"
}

module "my_ec2" {
  source = "../modules/ec2"
  ami_id = "ami-06ffade19910cbfc0"
  instance_type = "default"
  subnet_id = "${module.my_vpc.subnet_id}"
  ec2_count = "default"
  
}

