variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "VM platform"
}

variable "vm_web_core" {
  type        = number
  default     = "2"
  description = "VM platform cpu"
}

variable "vm_web_memory" {
  type        = number
  default     = "1"
  description = "VM platform memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = "5"
  description = "VM platform core_fraction"
}

### netology-develop-platform-db

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM name"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "VM platform"
}

variable "vm_db_core" {
  type        = number
  default     = "2"
  description = "VM platform cpu"
}

variable "vm_db_memory" {
  type        = number
  default     = "2"
  description = "VM platform memory"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = "20"
  description = "VM platform core_fraction"
}