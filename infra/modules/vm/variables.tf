variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
  default = "europe-central2-a"
}

variable "app_name" {
  type = string
}

variable "network" {
  description = "Self-link to network"
  type        = string
}

variable "subnet" {
  description = "Self-link to subnet"
  type        = string
}

variable "machine_type" {
  description = "Machine type"
  type        = string
  default     = "e2-micro"
}
