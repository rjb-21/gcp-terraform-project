variable "project_id" {
  type = string
}

variable "app_name" {
  type = string
}

resource "google_service_account" "app_sa" {
  account_id   = "${var.app_name}-sa"
  display_name = "Service account for ${var.app_name}"
}

# Cloud SQL access
resource "google_project_iam_member" "app_sa_sql" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.app_sa.email}"
}

# Secret Manager access
resource "google_project_iam_member" "app_sa_secrets" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.app_sa.email}"
}

output "app_sa_email" {
  value = google_service_account.app_sa.email
}
