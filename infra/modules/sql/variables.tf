variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "app_name" {
  type = string
}

variable "db_tier" {
  description = "SQL machine size"
  type        = string
  default     = "db-f1-micro"
}

variable "db_version" {
  description = "WDB version"
  type        = string
  default     = "POSTGRES_15"
}

variable "db_password" {
  description = "admin password"
  type        = string
  sensitive   = true
}

variable "subnet" {
  description = "Self link to subnet"
  type        = string
}

variable "network" {
  description = "Self link to VPN"
  type        = string
}

variable "environment" {
  type = string
}

