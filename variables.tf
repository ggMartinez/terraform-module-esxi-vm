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
  default = ""
}