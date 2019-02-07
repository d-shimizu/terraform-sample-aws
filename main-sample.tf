provider "aws" {
    region = "ap-northeast-1"
    profile = "default"
}

resource "aws_instance" "example" {
    ami = "ami-2a69be4c"
    instance_type = "t2.micro"
}
