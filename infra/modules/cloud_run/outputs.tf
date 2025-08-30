output "cloud_run_url" {
  description = "Public URL for Cloud Run service"
  value       = google_cloud_run_v2_service.app.uri
}

output "cloud_run_name" {
  description = "Name of Cloud Run service"
  value       = google_cloud_run_v2_service.app.name
}

output "cloud_run_region" {
  description = "Cloud Run region"
  value       = google_cloud_run_v2_service.app.location
}
