#cloud-config

runcmd:
  - date >/root/cloudinit.log
  - hostnamectl set-hostname ${HOSTNAME}
  - echo HELLO >>/root/cloudinit.log
  - echo "Done cloud-init" >>/root/cloudinit.log
