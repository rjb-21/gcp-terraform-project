variable "project_id" {
  type = string
}

variable "app_name" {
  type = string
}

variable "secrets" {
  description = "Secrets map"
  type        = map(string)
}

resource "google_secret_manager_secret" "secrets" {
  for_each  = var.secrets
  secret_id = "${var.app_name}-${each.key}"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "secrets" {
  for_each    = var.secrets
  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = each.value
}

output "secrets_ids" {
  value = { for k, v in google_secret_manager_secret.secrets : k => v.id }
}
