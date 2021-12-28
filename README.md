# VMware ESXi - Terraform Module

Terraform module to create ESXi VMs.


## Requirements
You can guess them...

 - Terraform installed on your host (at least version 0.13)
 - A host with VMware ESXi. VMs don't run in trees.
 - I love Centos 7, so you need a VM with the name "Centos7" for use as default template.
 Also, this must have VMware Tools, and Cloud-Init Datasource for VMware GuestInfo (https://github.com/vmware-archive/cloud-init-vmware-guestinfo) if you want to inject some code into the VM init.
 You can create another VM and override.

## References
Based on this repo: https://github.com/josenk/terraform-provider-esxi.
It may change, don't think I will watch it every day. So f*ck it.
