###cloud vars


variable "cloud_id" {
  type        = string
  description = "cloud-asv"
  default="b1gd2j85a1qkvque4sv7"
}

variable "folder_id" {
  type        = string
  description = "folder-asv"
  default="b1g58l0sc9sfdif3gs79"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "ru-central1-a-net-asv"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "default_cidr ru-central1-a"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network ru-central1-a & 10.0.1.0/24"
}

### netology-develop-platform-db
variable "ru-central1-b_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "ru-central1-b-net-asv"
}
variable "ru-central1-b_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "default_cidr ru-central1-b"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VPC network ru-central1-b & 10.0.2.0/24"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM OS image"
}
  

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFWU0VOTdkuWCe0B0iYaGAc5RuCNXX+bjdY5cB/vHer biparasite@Alexey.local"
  description = "ssh-keygen -t ed25519"
}
