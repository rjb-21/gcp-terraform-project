variable "project_id" {
  type    = string
  default = "terraform-470506"
}

variable "region" {
  type    = string
  default = "europe-central2"
}

variable "app_name" {
  description = "Test application name"
  type        = string
  default     = "terraform-helloworld-app"
}