vms_resources = {
  web={
    cores=2
    memory=2
    core_fraction=5
    hdd_size=10
    hdd_type="network-hdd"
  },
  db= {
    cores=2
    memory=4
    core_fraction=20
    hdd_size=10
    hdd_type="network-ssd"
  }
}

metadata = {
  serial-port-enable = 1
  ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFWU0VOTdkuWCe0B0iYaGAc5RuCNXX+bjdY5cB/vHer biparasite@Alexey.local"
}
