# VMware ESXi - Terraform Module

![ESXI Logo](https://www.nicepng.com/png/full/243-2432343_vmware-vsphere-logo.png)
![Terraform Logo](https://i.pinimg.com/originals/f4/54/15/f45415270449af33c39dcb1e8af5a62a.png)

Terraform module to create ESXi VMs. No need for vCenter. Works fine with ESXi Standalone Server.

For the poor people that stole bikes and don't have money for expensive services. 


## Requirements
You can guess them...

 - Terraform installed on your host (at least version 0.13)
 - A host with VMware ESXi Standalone Server. VMs don't run in trees.
 - A VM created on ESXi to use as template.
 - If you want to do some (not that much yet) cloud-init nasty things, you need install VMware Tools, and Cloud-Init Datasource for VMware GuestInfo on the template VM.
  
## Quick usage

Create a file named `main.tf` with this:

    module "vm1" {
      source = "github.com/ggMartinez/terraform-module-esxi-vm"
      esxiHostname = "192.168.X.X"
      guestHostname = "NewVM"
      templateVM = "ExistingVmThatIWantToClone"
      esxiPassword = "DicklessPassword"
    }

Then, run this commands:

    terraform init
    terraform apply


As the provider can't create more than one VM, this module neither. If you want to create N VMs with using this, you have to call the module N times. Not the most pretty, but it does the job
. 
## Variables (Inputs)
You can add more variables to the module for customizing the VM creation.

Here is a list of all variables that the module support:

 - esxiHostname
 - esxiSSHPort (default to 22)
 - esxiSSLPort (default to 443)
 - esxiUsername (default to root)
 - esxiPassword
 - virtualNetwork (default to "VM Network")
 - dataStore (default to "datastore1")
 - templateVM (default to "Centos7", but you can create another VM and use it as a template)
 - cpuCount (default to 1)
 - memSize(default to 1024, RAM must be specified in MB (go f*ck with MiB fancyness...)
 - powerOn (default to "on")
 - userData (default to some stupid hardcoded word)
 - vmStaticAddress (default to "false", not boolean but string)
 - vmIpAddress (only processed if enabled Static Address)
 - vmNetmask (defaults to "255.255.255.0")
 - vmDefaultGW (defaults to "192.168.1.1")
 - vmDNS1 (defaults to "8.8.8.8")
 - vmDNS2 (defaults to "8.8.4.4")
 - vmUsername 
 - vmSSHKey

## Outputs
The output is pretty bare. Just outputs the basic info from the created VM.
An example:

    VM-Info = {
      "CPU-Count" = "1"
      "GuestName" = "TESTVM"
      "GuestOS" = "centos7-64"
      "IP-Address" = "192.168.1.13"
      "RAM" = "1024"
      "TemplateName" = "Centos7"
    }

## VM Template
The provider can use an OVA image, but is not implemented here yet. Besides, I'm not a fan of importing random OVAs from internet. I rather write an user-data script and install stuff, or if I'm bored, just throw some Ansible/Docker into the ecuation.

This module only works with an existing VM to clone. Recomended to have VMware Tools and Cloud-Init Datasource for VMware GuestInfo (https://github.com/vmware-archive/cloud-init-vmware-guestinfo) if you want to inject some code into the VM init.

Only tested that on Centos 7. Should work fine with Centos 8, and others RHEL derivatives. 
Don't know what happens on Ubuntu or some other crap that stupid people uses for servers. Better be COVID-19 vaccinated if you are to do nasty things with nasty distros.

## Auth and user creation

A few things about user creation and all that stuff.

If you don't specify any value for the "vmUsername" variable, you must use the root password from the VM that you use as template (or a default user, depends on the VM that you create for template).

If you specify a value for the "vmUsername" variable, and also specify a ssh pub key in "vmSSHKey" variable, then the user will be created with a random password, added to the sudoers, and the SSH key added for login, so you don't depend on password.

If you specify a value for the "vmUsername" variable, and don't specify a ssh pub key, then a random password will be created and assigned to the user, and saved in a file in the home directory for the user, and also will be added to sudoers. Since you need to have other type of access to retrieve the file, pretty useless, but whatever, there may be someone who need to add an user without SSH Key. 


## User Data
When a VM is created, it has a minimal user-data script passed to the VM via cloud-init that changes the VM hostname to the name of the VM. 
You can create a script, and specify its path in the variable `userData` for the module to load it and run it AFTER the default cloud-init script. 
If you don't specify it, it will only run the default one. Pretty easy.


## Quick notes
- User Data is only tested on Centos 7. May work with another distro, but whatever.
- I only tested this on ESXi 7. I guess it will work on early versions, but only have one server in home to test stuff, and I will not be installing an early version just to test this.
- I don't know if this will work on vCenter. But it is pointless, as there are a f*ck ton of modules out there in the wild focused on that, that are more complete and better than this one. I only made this so I don't have to manually install VMs when doing some tests with a server at home. 
- Guess this can be used in small production environments if you have a few ESXi servers and no vCenter. **But I recomend using this ONLY FOR TESTING**. Don't have intentions for the moment to dedicate much time on this. My main focus is AWS, not ESXi. Long live the Cloud. 


## References
Based on this repo: https://github.com/josenk/terraform-provider-esxi.
It may change, don't think I will watch it every day. So f*ck it.
