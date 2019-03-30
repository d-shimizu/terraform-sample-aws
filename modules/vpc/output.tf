output "terraform_example_vpc_id" {
  value = "${aws_vpc.terraform_example_vpc.id}"
}

output "terraform_example_subnet_public-a_id" {
  value = "${aws_subnet.terraform_example_subnet_public-a.id}"
}

output "terraform_example_subnet_public-c_id" {
  value = "${aws_subnet.terraform_example_subnet_public-c.id}"
}
