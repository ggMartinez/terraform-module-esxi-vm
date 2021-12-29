#!/bin/bash


setIpAddress() {
    nmcli con mod ${NETWORK_INTERFACE} ipv4.method manual
    nmcli con mod ${NETWORK_INTERFACE} ipv4.address ${IP_ADDR}/$(ipcalc -p 1.1.1.1 -m ${NETMASK}| grep PREFIX| cut -d"=" -f2)
    nmcli con mod ${NETWORK_INTERFACE} ipv4.gateway ${GATEWAY}
    nmcli con mod ${NETWORK_INTERFACE} ipv4.dns "${DNS1},${DNS2}"

    systemctl restart NetworkManager
}
date > /var/log/cloud-init-custom.log
hostnamectl set-hostname ${HOSTNAME}


createUser(){
    useradd -m ${USERNAME}
    PASS=$(openssl rand -base64 32)
    echo $PASS |  passwd --stdin ${USERNAME}
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

    if ! [ -z ${SSH_KEY} ]
    then
        mkdir -p /home/${USERNAME}/.ssh
        echo ${SSH_KEY} > /home/${USERNAME}/.ssh/authorized_keys
        chown ${USERNAME} /home/${USERNAME}/.ssh/ -R
    else
        echo $PASS > /home/${USERNAME}/generated_pass.txt
    fi
}




if  [ ${STATIC_IP} = "true"]
then
    setIpAddress 2>&1 > /var/log/net-init.log
fi

if ! [ -z ${USERNAME} ]
    createUser 2>&1 > /var/log/create-user.log
fi

echo "Done cloud-init" >>/var/log/cloud-init-custom.log


