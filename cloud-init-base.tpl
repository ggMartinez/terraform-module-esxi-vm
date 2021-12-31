#!/bin/bash


date > /var/log/cloud-init-custom.log
hostnamectl set-hostname ${HOSTNAME}

if  [ "${STATIC_IP}" = "true" ]
then
    echo "IP ADDRESS: ${IP_ADDR}" >> /var/log/cloud-init-custom.log
    echo "NETMASK: ${NETMASK}" >> /var/log/cloud-init-custom.log
    echo "GATEWAY: ${GATEWAY}" >> /var/log/cloud-init-custom.log
    echo "DNS1 & DNS2: ${DNS1} ${DNS2}" >> /var/log/cloud-init-custom.log

    DEVICE=$(nmcli d| grep connected| tr -s " " | cut -d" " -f1)
    INTERFACE="System $DEVICE"
    nmcli con down "$INTERFACE"
    nmcli con mod "$INTERFACE" ipv4.method manual
    nmcli con mod "$INTERFACE" ipv4.address ${IP_ADDR}/$(ipcalc -p 1.1.1.1 -m ${NETMASK}| grep PREFIX| cut -d"=" -f2)
    nmcli con mod "$INTERFACE" ipv4.gateway ${GATEWAY}
    nmcli con mod "$INTERFACE" ipv4.dns "${DNS1},${DNS2}"
    nmcli con up "$INTERFACE"
    nmcli device disconnect $DEVICE; wait ; nmcli device connect $DEVICE
    systemctl restart NetworkManager
fi

if ! [ -z "${USERNAME}" ]
then
    echo "Creating User ${USERNAME}" >>  /var/log/cloud-init-custom.log

    useradd -m ${USERNAME}
    PASS=$(openssl rand -base64 32)
    echo $PASS |  passwd --stdin ${USERNAME}
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

    if ! [ -z "${SSH_KEY}" ]
    then
        echo "ADDING KEY ${SSH_KEY}" >>  /var/log/cloud-init-custom.log


        mkdir -p /home/${USERNAME}/.ssh
        echo "${SSH_KEY}" > /home/${USERNAME}/.ssh/authorized_keys
        chown ${USERNAME} /home/${USERNAME}/.ssh/ -R
    else
        echo $PASS > /home/${USERNAME}/generated_pass.txt
    fi
fi

echo "Done cloud-init" >>/var/log/cloud-init-custom.log


