provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = "ap-northeast-1"
  profile = "default"
}


# VPC
resource "aws_vpc" "this" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "tf-example-vpc"
  }
}


# InternetGateway
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"
}

# RouteTable
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }
  tags {
    Name = "public"
  }
}

# Subnet
resource "aws_subnet" "public_a" {
  vpc_id = "${aws_vpc.this.id}"
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags {
    Name = "public-a"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id = "${aws_vpc.this.id}"
  cidr_block = "10.1.2.0/24"
  availability_zone = "ap-northeast-1c"
  tags {
    Name = "public-c"
  }
}

resource "aws_subnet" "public_d" {
  vpc_id = "${aws_vpc.this.id}"
  cidr_block = "10.1.3.0/24"
  availability_zone = "ap-northeast-1d"
  tags {
    Name = "public-d"
  }
}

# SubnetRouteTableAssociation
resource "aws_route_table_association" "public_a" {
    subnet_id = "${aws_subnet.public_a.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_c" {
    subnet_id = "${aws_subnet.public_c.id}"
    route_table_id = "${aws_route_table.public.id}"
}



# Security Group
resource "aws_security_group" "this" {
    name = "APP_SG"
    vpc_id = "${aws_vpc.this.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "tf-example-sg"
}

# EC2
resource "aws_instance" "this_t2" {
    ami = "ami-2a69be4c"
    instance_type = "t2.micro"
  disable_api_termination = false
  key_name                = "aws-key-pair"
  vpc_security_group_ids  = ["${aws_security_group.this.id}"]
  subnet_id               = "${aws_subnet.public_a.id}"

  tags {
    Name = "tf-example-ec2"
  }
}

# ElasticIP
resource "aws_eip" "this" {
    instance = "${aws_instance.this_t2.id}"
    vpc = true
}
