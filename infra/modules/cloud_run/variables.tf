variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-central2"
}

variable "image" {
  type        = string
  description = "Container image to deploy"
}

variable "db_instance_connection_name" {
  type        = string
  description = "Cloud SQL instance connection name"
}

variable "db_user" {
  type        = string
  default     = "postgres"
}

variable "db_password_secret_name" {
  type        = string
  description = "Name of the secret in Secret Manager storing DB password"
}

variable "vpc_connector" {
  type        = string
  description = "Serverless VPC connector name"
}

variable "service_account_email" {
  type        = string
  description = "Service account used by Cloud Run"
}
