#!/bin/bash

date >/root/cloudinit.log
hostnamectl set-hostname ${HOSTNAME}
echo "Done cloud-init" >>/root/cloudinit.log


