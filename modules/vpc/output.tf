output "tf_sample_vpc_id" {
  value = "${aws_vpc.tf_sample_vpc.id}"
}

output "tf_sample_public-a_subnet_id" {
  value = "${aws_subnet.tf_sample_public-a_subnet.id}"
}

output "tf_sample_public-c_subnet_id" {
  value = "${aws_subnet.tf_sample_public-c_subnet.id}"
}
