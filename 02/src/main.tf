resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

### ru-central1-b net
resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vm_db_vpc_name
  zone           = var.ru-central1-b_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.ru-central1-b_default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

### default vm
resource "yandex_compute_instance" "platform" {
  name        = local.web_name
  platform_id = var.vm_web_platform
  zone        = var.default_zone
  resources {
    cores         = var.vm_web_core
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}

### db_wm

resource "yandex_compute_instance" "platform-db" {
  name        = local.db_name
  platform_id = var.vm_web_platform
  zone = var.ru-central1-b_zone
  resources {
    cores         = var.vm_db_core
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
