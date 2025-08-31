variable "project_id" {
  type = string
}

variable "app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

resource "google_storage_bucket" "app_bucket" {
  name          = "${var.project_id}-${var.app_name}-bucket-${var.environment}"
  project       = var.project_id
  location      = var.location
  force_destroy = true
  uniform_bucket_level_access = true
}

output "bucket_name" {
  value = google_storage_bucket.app_bucket.name
}
