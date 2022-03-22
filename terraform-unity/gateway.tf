resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = data.aws_vpc.Unity-Dev-VPC.id
  tags = {
    Name       = "test-env-gw"
    Deployment = "unity-demo"
  }
}