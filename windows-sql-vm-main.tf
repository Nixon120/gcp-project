resource "google_compute_instance" "vm_instance_public" {
  name         = "kopicloud-vm"
  machine_type = var.windows_sql_instance_type
  hostname     = "kopicloud-vm.kopicloud.com"
  zone         = "us-central1-b"
  tags         = ["rdp", "sql"]
  boot_disk {
    initialize_params {
      image = var.windows_2022_sql_2019_web_sku
    }
  }
  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network_subnet.name
    access_config {}
  }
}
