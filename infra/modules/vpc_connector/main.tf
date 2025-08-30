resource "google_vpc_access_connector" "connector" {
  name         = var.name
  project      = var.project_id
  region       = var.region
  network      = var.network
  ip_cidr_range = var.ip_cidr_range
  min_instances = 2
  max_instances = 10
}
