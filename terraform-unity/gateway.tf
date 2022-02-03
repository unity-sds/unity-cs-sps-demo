resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.unity-test-env.id}"
  tags = {
    Name = "test-env-gw"
  }
}