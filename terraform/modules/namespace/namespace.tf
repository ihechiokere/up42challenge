# terraform/modules/namespace/main.tf

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = var.name
    labels = var.labels
    annotations = var.annotations
  }
}