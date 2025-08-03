# terraform/modules/helm-release/main.tf

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

resource "helm_release" "this" {
  name       = var.name
  chart      = var.chart_path
  namespace  = var.namespace
  
  # Application configuration
  set {
    name  = "s3www.replicas"
    value = var.replica_count
  }
  
  set {
    name  = "ingress.enabled"
    value = var.enable_ingress
  }
  
  set {
    name  = "ingress.hostname"
    value = var.ingress_hostname
  }
  
  set {
    name  = "monitoring.enabled"
    value = var.enable_monitoring
  }
  
  set {
    name  = "minio.storage"
    value = var.minio_storage
  }
  
  # Additional settings
  timeout         = var.timeout
  wait           = var.wait
  cleanup_on_fail = var.cleanup_on_fail
}