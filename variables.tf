#  Change these defaults to fit your needs!

variable "esxiHostname" {
}

variable "esxiSSHPort" {
   default = "22"
}

variable "esxiSSLPort" {
   default = "443"
}

variable "esxiUsername" {
   default = "root"
}

variable "esxiPassword" {
}

variable "virtualNetwork" {
   default = "VM Network"
}

variable "dataStore" {
   default = "datastore1"
}

variable "templateVM" {
   default = "Centos7"
}

variable "guestHostname" {
}

variable "cpuCount" {
   default = "1"
}

variable "memSize" {
   default = "1024"
}

variable "powerOn" {
   default = "on"
}

variable "userData" {
  default = "sopenco"
}



variable "vmStaticIp" { 
   default = "false"
}

variable "vmIpAddress" {
   default = null
}

variable "vmNetmask" {
   default = "255.255.255.0"
}

variable "vmDefaultGW" {
   default = "192.168.1.1"
}

variable "vmDNS1" {
   default = "8.8.8.8"
}

variable "vmDNS2" {
   default = "8.8.4.4"
}

variable "vmUsername" {
   default = null
}

variable "vmSSHKey" {
   default = null
}
