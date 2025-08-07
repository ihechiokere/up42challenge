terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "namespace" {
  source = "../modules/namespace"
  
  name = "${var.application}-${var.environment}"
  labels = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

module "helm_release" {
  source = "../modules/helm-release"
  
  name         = "${var.application}-${var.environment}"
  namespace    = module.namespace.name
  chart_path   = var.chart_path
  
  replica_count    = var.replica_count
  enable_ingress   = var.enable_ingress
  ingress_hostname = var.ingress_hostname
  enable_monitoring = var.enable_monitoring
  minio_storage    = var.minio_storage
  
  depends_on = [module.namespace]
}