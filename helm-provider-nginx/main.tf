provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "applications-namespace" {
  metadata {
        name = "nginx"
  }
}


resource "helm_release" "nginx" {
  name       = "nginx"
  namespace  = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"

  set {
    name  = "service.type"
    value = "NodePort"
  }

  set {
    name  = "service.nodePorts.http"
    value = "30201"
  }
  
}
