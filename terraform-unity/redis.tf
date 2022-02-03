resource "aws_memorydb_cluster" "unity-db-sample" {
  acl_name                 = "open-access"
  name                     = "unity-cluster"
  node_type                = "db.t4g.small"
  num_shards               = 2
  security_group_ids       = [aws_security_group.redis_sg.id]
  snapshot_retention_limit = 7
  subnet_group_name        = aws_memorydb_subnet_group.example.name
}

resource "aws_memorydb_subnet_group" "example" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.subnet-uno.id, aws_subnet.subnet-two.id]
}