# VPC
resource "aws_vpc" "terraform_example_vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "tf-example-vpc"
  }
}

# InternetGateway
resource "aws_internet_gateway" "terraform_example_igw" {
  vpc_id = "${aws_vpc.terraform_example_vpc.id}"
}

# RouteTable
resource "aws_route_table" "terraform_example_public_rt" {
  vpc_id = "${aws_vpc.terraform_example_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terraform_example_igw.id}"
  }

  tags {
    Name = "public"
  }
}

# Subnet
resource "aws_subnet" "terraform_example_subnet_public-a" {
  vpc_id            = "${aws_vpc.terraform_example_vpc.id}"
  cidr_block        = "10.1.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags {
    Name = "public-a"
  }
}

resource "aws_subnet" "terraform_example_subnet_public-c" {
  vpc_id            = "${aws_vpc.terraform_example_vpc.id}"
  cidr_block        = "10.1.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags {
    Name = "public-c"
  }
}

resource "aws_subnet" "terraform_example_subnet_public-d" {
  vpc_id            = "${aws_vpc.terraform_example_vpc.id}"
  cidr_block        = "10.1.3.0/24"
  availability_zone = "ap-northeast-1d"

  tags {
    Name = "public-d"
  }
}

# SubnetRouteTableAssociation
resource "aws_route_table_association" "terraform_example_rt_public-a" {
  subnet_id      = "${aws_subnet.terraform_example_subnet_public-a.id}"
  route_table_id = "${aws_route_table.terraform_example_public_rt.id}"
}

resource "aws_route_table_association" "terraform_example_rt_public-c" {
  subnet_id      = "${aws_subnet.terraform_example_subnet_public-c.id}"
  route_table_id = "${aws_route_table.terraform_example_public_rt.id}"
}
