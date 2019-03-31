# VPC
resource "aws_vpc" "tf_sample_vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "tf-sample-vpc"
  }
}

# InternetGateway
resource "aws_internet_gateway" "tf_sample_igw" {
  vpc_id = "${aws_vpc.tf_sample_vpc.id}"
}

# RouteTable
resource "aws_route_table" "tf_sample_public_rt" {
  vpc_id = "${aws_vpc.tf_sample_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_sample_igw.id}"
  }

  tags {
    Name = "tf-sample-public-rt"
  }
}

# Subnet
resource "aws_subnet" "tf_sample_public-a_subnet" {
  vpc_id            = "${aws_vpc.tf_sample_vpc.id}"
  cidr_block        = "10.1.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags {
    Name = "tf-sample-public-a-subnet"
  }
}

resource "aws_subnet" "tf_sample_public-c_subnet" {
  vpc_id            = "${aws_vpc.tf_sample_vpc.id}"
  cidr_block        = "10.1.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags {
    Name = "tf-sample-public-c-subnet"
  }
}

resource "aws_subnet" "tf_sample_public-d_subnet" {
  vpc_id            = "${aws_vpc.tf_sample_vpc.id}"
  cidr_block        = "10.1.3.0/24"
  availability_zone = "ap-northeast-1d"

  tags {
    Name = "tf-sample-public-d-subnet"
  }
}

# SubnetRouteTableAssociation
resource "aws_route_table_association" "tf_sample_public-a_rt" {
  subnet_id      = "${aws_subnet.tf_sample_public-a_subnet.id}"
  route_table_id = "${aws_route_table.tf_sample_public_rt.id}"
}

resource "aws_route_table_association" "terraform_example_rt_public-c" {
  subnet_id      = "${aws_subnet.tf_sample_public-c_subnet.id}"
  route_table_id = "${aws_route_table.tf_sample_public_rt.id}"
}
