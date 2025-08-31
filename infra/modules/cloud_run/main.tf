resource "google_cloud_run_v2_service" "app" {
  name     = "helloworld-${var.environment}"
  location = var.region

  deletion_protection = false

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 3
    }

    vpc_access {
      connector = "projects/${var.project_id}/locations/${var.region}/connectors/${var.vpc_connector}"
      egress    = "ALL_TRAFFIC"
    }

    containers {
      image = var.image 

      ports {
        container_port = 8080
      }

      env {
        name  = "DB_INSTANCE_CONNECTION_NAME"
        value = var.db_instance_connection_name
      }

      env {
        name  = "DB_USER"
        value = var.db_user
      }

      env {
        name = "DB_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = var.db_password_secret_name
            version = "latest"
          }
        }
      }
    }

    service_account = var.service_account_email
  }

  ingress = "INGRESS_TRAFFIC_ALL"
}


resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  name     = google_cloud_run_v2_service.app.id 
  location = google_cloud_run_v2_service.app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
