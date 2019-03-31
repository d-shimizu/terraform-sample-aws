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

  tf_sample_vpc_id = "${module.vpc.tf_sample_vpc_id}"
  tf_sample_public-a_subnet_id = "${module.vpc.tf_sample_public-a_subnet_id}"
  tf_sample_public-c_subnet_id = "${module.vpc.tf_sample_public-c_subnet_id}"
}
