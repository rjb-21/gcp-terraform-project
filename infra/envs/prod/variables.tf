variable "project_id" {
  type    = string
  default = "terraform-470506"
}

variable "region" {
  description = "Region for SQL etc."
  type        = string
}

variable "location_bucket" {
  description = "Multiregion for bucket"
  type        = string
}

variable "app_name" {
  description = "Test application name"
  type        = string
  default     = "terraform-helloworld-app"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "api_key" {
  type      = string
  sensitive = true
}

variable "environment" {
  description = "Environment type"
  type        = string
}

