provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

# VPC
module "module_vpc" {
  source = "../modules/vpc"
}

module "module_ec2" {
  source = "../modules/ec2"

  vpc_id = "${module.module_vpc.vpc_id}"
  subnet_public_a_id = "${module.module_vpc.subnet_public_a_id}"
  subnet_public_c_id = "${module.module_vpc.subnet_public_c_id}"
}
