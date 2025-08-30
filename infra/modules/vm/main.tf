resource "google_compute_firewall" "iap_ssh" {
  name    = "${var.app_name}-allow-iap-ssh"
  network = var.network
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  direction     = "INGRESS"
  target_tags   = ["allow-iap-ssh"]
}


resource "google_compute_instance" "vm" {
  name         = "${var.app_name}-vm"
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type

  tags = ["allow-iap-ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y postgresql-client
  EOT
}

output "vm_external_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "vm_internal_ip" {
  value = google_compute_instance.vm.network_interface[0].network_ip
}
