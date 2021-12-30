
data "template_file" "userdata_default" {
  template = file("${path.module}/cloud-init-base.tpl")
  vars = {
    HOSTNAME = var.guestHostname
    STATIC_IP = var.vmStaticIp
    IP_ADDR = var.vmIpAddress
    NETMASK = var.vmNetmask
    GATEWAY = var.vmDefaultGW
    DNS1 = var.vmDNS1
    DNS2 = var.vmDNS2
    USERNAME = var.vmUsername
    SSH_KEY = var.vmSSHKey
  }
}

data "template_file" "userdata" {
  template = fileexists(var.userData) ? file(var.userData) : file("${path.module}/cloud-init-null.tpl")
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
    "userdata"          = base64gzip(format("%s%s",data.template_file.userdata_default.rendered,data.template_file.userdata.rendered))
  }
}

