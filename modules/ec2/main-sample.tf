variable "vpc_id" {}
variable "subnet_public_a_id" {}
variable "subnet_public_c_id" {}

# Security Group
resource "aws_security_group" "this" {
  name   = "tf-example-sg"
  vpc_id = "${var.vpc_id}"

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
resource "aws_instance" "this_t2" {
  ami                     = "ami-2a69be4c"
  instance_type           = "t2.micro"
  disable_api_termination = false
  key_name                = "aws-key-pair"
  vpc_security_group_ids  = ["${aws_security_group.this.id}"]
  subnet_id               = "${var.subnet_public_a_id}"

  tags {
    Name = "tf-example-ec2"
  }
}

resource "aws_eip" "this" {
  instance = "${aws_instance.this_t2.id}"
  vpc      = true
}
