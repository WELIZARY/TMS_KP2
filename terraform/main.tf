terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
  backend "gcs" {
    bucket = "dos32-terraform-state-dos32-terraform"
    prefix = "terraform/tms-kp2"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "${var.region}-a"
}

# Статический айпишник
resource "google_compute_address" "static_ip" {
  name   = "quote-generator-ip"
  region = var.region
}

#  открываем порты  22, 5000, 5001, 8080
resource "google_compute_firewall" "allow_devops" {
  name    = "allow-devops-ports"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "5000", "5001", "8080"]
  }

  # только с моего  ip
  source_ranges = [var.allowed_cidr]
  target_tags   = ["quote-generator"]
}

module "quote_vm" {
  source        = "./modules/vm"
  instance_name = "quote-generator-vm"
  machine_type  = "e2-medium"
  zone          = "${var.region}-a"
  image         = "ubuntu-os-cloud/ubuntu-2204-lts"
  network       = "default"
  tags          = ["quote-generator"]
  static_ip     = google_compute_address.static_ip.address
}

output "vm_public_ip" {
  value       = module.quote_vm.instance_ip
  description = "публичный ip"
}
