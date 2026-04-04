resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.cluster_location
  network                  = google_compute_network.main.id
  subnetwork               = google_compute_subnetwork.private.id
  enable_autopilot = true
  deletion_protection = false

