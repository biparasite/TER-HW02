locals {
    web_name = "${var.vpc_name}-${var.vm_web_image}"
    db_name  = "${var.vm_db_vpc_name}-${var.vm_web_image}"
}
