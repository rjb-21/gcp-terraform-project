variable "project_id" { 
    type = string 
}

variable "region"     { 
    type = string
}

variable "app_name"   { 
    type = string
}

variable "environment" {
  type = string
}


resource "google_compute_network" "vpc" {
  name                    = "${var.app_name}-vpc-${var.environment}"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.app_name}-subnet-${var.environment}"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

output "network_self_link" {
  value = google_compute_network.vpc.self_link
}

output "subnet_self_link" {
  value = google_compute_subnetwork.subnet.self_link
}
