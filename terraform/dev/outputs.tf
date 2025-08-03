# terraform/outputs.tf

output "namespace" {
  description = "Application namespace"
  value       = module.namespace.name
}

output "application_url" {
  description = "Application URL"
  value = var.enable_ingress ? "http://${var.ingress_hostname}" : "Run 'kubectl get svc -n ${module.namespace.name}' for external IP"
}

output "helm_release_status" {
  description = "Helm release status"
  value       = module.helm_release.status
}