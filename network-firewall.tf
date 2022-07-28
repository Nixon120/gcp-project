# allow rdp
resource "google_compute_firewall" "allow-rdp" {
  name    = "kopicloud-fw-allow-rdp"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rdp"]
}
# allow sql
resource "google_compute_firewall" "allow-sql" {
  name    = "kopicloud-fw-allow-sql"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["1433"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["sql"]
}
