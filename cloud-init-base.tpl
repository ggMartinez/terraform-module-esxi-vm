#!/bin/bash

date > /var/log/cloud-init-custom.log
hostnamectl set-hostname ${HOSTNAME}
echo "Done cloud-init" >>/var/log/cloud-init-custom.log


