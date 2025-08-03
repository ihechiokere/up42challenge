# terraform/modules/namespace/variables.tf

variable "name" {
  description = "Namespace name"
  type        = string
}

variable "labels" {
  description = "Labels for the namespace"
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Annotations for the namespace"
  type        = map(string)
  default     = {}
}