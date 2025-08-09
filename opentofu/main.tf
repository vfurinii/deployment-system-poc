terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
}

provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/config")
  }
}

# Create namespaces
resource "kubernetes_namespace" "infra" {
  metadata { name = "infra" }
}
resource "kubernetes_namespace" "apps" {
  metadata { name = "apps" }
}

# Install kube-prometheus-stack helm release
resource "helm_release" "kube_prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.infra.metadata[0].name
  values     = [file("../k8s/prometheus-values.yaml")]
}

output "prometheus_namespace" {
  value = kubernetes_namespace.infra.metadata[0].name
}