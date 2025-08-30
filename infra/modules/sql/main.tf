resource "google_compute_global_address" "private_ip_range" {
  name          = "${var.app_name}-private-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
}

resource "google_sql_database_instance" "db" {
  name             = "${var.app_name}-db"
  project          = var.project_id
  region           = var.region
  database_version = var.db_version

  settings {
    tier = var.db_tier
    ip_configuration {
      ipv4_enabled = true
      private_network = var.network
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_user" "db_user" {
  name     = "appuser"
  instance = google_sql_database_instance.db.name
  password = var.db_password
  project  = var.project_id
}

resource "google_secret_manager_secret" "db_password" {
  secret_id = "${var.app_name}-db-password"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.db_password
}

output "db_instance_connection_name" {
  value = google_sql_database_instance.db.connection_name
}
