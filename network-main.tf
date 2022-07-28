# create VPC
resource "google_compute_network" "vpc" {
  name                    = "kopicloud-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}
# create public subnet
resource "google_compute_subnetwork" "network_subnet" {
  name          = "kopicloud-subnet"
  ip_cidr_range = var.network-subnet-cidr
  network       = google_compute_network.vpc.id
  region        = var.gcp_region
}

resource "google_dns_managed_zone" "private-zone" {
  name        = "private-zone"
  dns_name    = var.dns_address
  description = "kopicloud private DNS zone"
  labels = {
    description = "DNS zone"
  }

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc.id
    }
    networks {
      network_url = google_compute_network.vpc.id
    }
  }
}

resource "google_dns_record_set" "vm_instance_public" {
  name = "vm_instance_public.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.private-zone.name

  rrdatas = [google_compute_instance.vm_instance_public.network_interface[0].access_config[0].nat_ip]
}