resource "aws_elasticsearch_domain" "unity-sample" {
  domain_name           = "unityexample"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type = "i2.xlarge.elasticsearch"
    instance_count = 2
    zone_awareness_enabled = true
    zone_awareness_config {
      availability_zone_count = 2
    }
  }
  vpc_options {
    subnet_ids = [
      aws_subnet.subnet-uno.id,
      aws_subnet.subnet-two.id,
    ]

    security_group_ids = [aws_security_group.es.id]
  }

  ebs_options {
    ebs_enabled = false
  }
  advanced_security_options {
    enabled = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name = "unitymaster"
      master_user_password = "Un1typa$$word"
    }
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }
  node_to_node_encryption {
    enabled = true
  }
  encrypt_at_rest {
    enabled = true
  }
  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/unityexample/*"
        }
    ]
}
CONFIG
  tags = {
    Domain = "unity"
    Deployment = "unity-demo"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

