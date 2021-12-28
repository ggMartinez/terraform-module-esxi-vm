
data "template_file" "userdata_default" {
  template = file("${path.module}/cloud-init-base.tpl")
  vars = {
    HOSTNAME = var.guestHostname
  }
}

data "template_cloudinit_config" "userdata" {
  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.userdata_default.rendered}"
  }

}




resource "esxi_guest" "vmguest" {
  guest_name         = var.guestHostname
  disk_store         = var.dataStore
  clone_from_vm      = var.templateVM
  memsize = var.memSize
  numvcpus = var.cpuCount
  power = var.powerOn

  network_interfaces {
    virtual_network = var.virtualNetwork
  }

  guestinfo = {
    "userdata.encoding" = "gzip+base64"
    "userdata"          = base64gzip(data.template_cloudinit_config.userdata.rendered)
  }
}

