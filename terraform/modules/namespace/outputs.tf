# terraform/modules/namespace/outputs.tf

output "name" {
  description = "Namespace name"
  value       = kubernetes_namespace.this.metadata[0].name
}

output "id" {
  description = "Namespace resource ID"
  value       = kubernetes_namespace.this.id
}