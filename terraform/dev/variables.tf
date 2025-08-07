variable "application" {
  description = "Application name"
  type        = string
  default     = "s3www"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "chart_path" {
  description = "Path to Helm chart"
  type        = string
  default     = "../../helm/s3www"
}

variable "replica_count" {
  description = "Number of s3www replicas"
  type        = number
  default     = 1
}

variable "enable_ingress" {
  description = "Enable Ingress"
  type        = bool
  default     = false
}

variable "ingress_hostname" {
  description = "Ingress hostname"
  type        = string
  default     = "s3www-dev.local"
}

variable "enable_monitoring" {
  description = "Enable ServiceMonitor (requires metrics-server)"
  type        = bool
  default     = true
}

variable "minio_storage" {
  description = "MinIO storage size"
  type        = string
  default     = "5Gi"
}