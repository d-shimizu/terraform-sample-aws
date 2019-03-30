provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

# VPC
module "vpc" {
  source = "../modules/vpc"
}

module "ec2" {
  source = "../modules/ec2"
  tf_vpc_id = "${module.vpc.terraform_example_vpc_id}"
  terraform_example_subnet_public-a = "${module.vpc.terraform_example_subnet_public-a_id}"
  terraform_example_subnet_public-c = "${module.vpc.terraform_example_subnet_public-c_id}"
}
