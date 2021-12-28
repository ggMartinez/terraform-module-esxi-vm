output "Guest Name" {
  value = esxi_guest.vmguest.guest_name
}
output "IP Address" {
  value = esxi_guest.vmguest.ip_address
}

output "RAM" {
  value = esxi_guest.vmguest.memsize
}

output "CPU Count" {
  value = esxi_guest.vmguest.numvcpus
}

output "Guest OS" {
  value = esxi_guest.vmguest.guestos
}

output "Template Name" {
  value = esxi_guest.vmguest.clone_from_vm
}