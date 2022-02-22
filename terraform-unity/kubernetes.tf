provider "helm" {
  kubernetes {
    config_path = "./kubeconfig.yaml"
    insecure    = true
  }
}

resource "helm_release" "mozart" {
  name       = "mozart"
  wait       = false
  repository = "https://unity-sds.github.io/unity-helm-repository"
  chart      = "sps"

  set {
    name  = "elastic"
    value = format("https://%s:443", aws_elasticsearch_domain.unity-sample.endpoint)
  }

  set {
    name  = "redis"
    value = aws_memorydb_cluster.unity-db-sample.cluster_endpoint[0].address
  }
  depends_on = [aws_memorydb_cluster.unity-db-sample, aws_elasticsearch_domain.unity-sample]
}
