# terraform/modules/helm-release/variables.tf

variable "name" {
  description = "Helm release name"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "chart_path" {
  description = "Path to Helm chart"
  type        = string
}

variable "replica_count" {
  description = "Number of s3www replicas"
  type        = number
  default     = 2
}

variable "enable_ingress" {
  description = "Enable Ingress"
  type        = bool
  default     = true
}

variable "ingress_hostname" {
  description = "Ingress hostname"
  type        = string
  default     = "s3www.local"
}

variable "enable_monitoring" {
  description = "Enable ServiceMonitor (requires Prometheus Operator)"
  type        = bool
  default     = false
}

variable "minio_storage" {
  description = "MinIO storage size"
  type        = string
  default     = "10Gi"
}

variable "timeout" {
  description = "Helm install timeout"
  type        = number
  default     = 300
}

variable "wait" {
  description = "Wait for resources to be ready"
  type        = bool
  default     = true
}

variable "cleanup_on_fail" {
  description = "Cleanup resources on failure"
  type        = bool
  default     = true
}