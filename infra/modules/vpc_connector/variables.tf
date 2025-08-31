variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "name" {
  type        = string
  description = "Name of VPC Connectora"
  default     = "serverless-connector"
}

variable "network" {
  type        = string
  description = "Self-link to VPC network"
}

variable "ip_cidr_range" {
  type        = string
  description = "CIDR range for connectora"
  default     = "10.8.0.0/28"
}

variable "environment" {
  type = string
}