#! /bin/zsh
FIRST_BOOT() {
if [ ${WORKDIR} != /DIR ] && [ ${WORKDIR} != /DIR/ ]
then
    if [ "$(ls -A $WORKDIR)" = "" ]
    then 
        mv /DIR ${WORKDIR}
    else
    fi
fi
echo "root:${PASSWORD}" | chpasswd
}

BOOT() {
    code-server --bind-addr 0.0.0.0:8080 ${WORKDIR}
}

if [ ! -f /DOCKER_BOOT_LOCK ];then
    echo "FIRST BOOT"
    touch /DOCKER_BOOT_LOCK
    FIRST_BOOT
    BOOT
else
    echo "REBOOT"
    BOOT
fi