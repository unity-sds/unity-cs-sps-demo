variable "ami_name" { default = "unity-ubuntu" }
variable "ami_id" { default = "ami-0688ba7eeeeefe3cd" }
#variable "ami_id" { default = "ami-04505e74c0741db8d" }
variable "ami_key_pair_name" { default = "unity-cs-smolensk" }
#variable "vpc_id" { default = "vpc-0fd177185e450d73d" }

data "aws_vpc" "unity-test-env" {
  id         = "vpc-0106218dbddd3a753"
  cidr_block = "10.0.0.0/16"
}
