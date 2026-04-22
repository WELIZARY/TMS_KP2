resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network

    # внешний адрес
    access_config {
      nat_ip = var.static_ip
    }
  }

  tags = var.tags
}

output "instance_name" {
  value = google_compute_instance.vm.name
}

output "instance_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
