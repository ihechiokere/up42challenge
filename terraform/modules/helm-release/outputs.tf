# terraform/modules/helm-release/outputs.tf

output "name" {
  description = "Helm release name"
  value       = helm_release.this.name
}

output "namespace" {
  description = "Helm release namespace"
  value       = helm_release.this.namespace
}

output "version" {
  description = "Helm release version"
  value       = helm_release.this.version
}

output "status" {
  description = "Helm release status"
  value       = helm_release.this.status
}