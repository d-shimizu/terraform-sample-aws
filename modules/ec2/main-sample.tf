variable "tf_vpc_id" {}
variable "terraform_example_subnet_public-a" {}
variable "terraform_example_subnet_public-c" {}

# Security Group
resource "aws_security_group" "terraform_example_sg" {
  name   = "tf_app_sg"
  vpc_id = "${var.tf_vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  description = "tf-example-sg"
}

# EC2
resource "aws_instance" "terraform_example_ec2" {
  ami                     = "ami-2a69be4c"
  instance_type           = "t2.micro"
  disable_api_termination = false
  key_name                = "aws-key-pair"
  vpc_security_group_ids  = ["${aws_security_group.terraform_example_sg.id}"]
  subnet_id               = "${var.terraform_example_subnet_public-a}"

  tags {
    Name = "tf-example-ec2"
  }
}

resource "aws_eip" "terraform_example_eip" {
  instance = "${aws_instance.terraform_example_ec2.id}"
  vpc      = true
}
