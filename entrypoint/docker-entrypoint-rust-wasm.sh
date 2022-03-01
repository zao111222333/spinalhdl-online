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
for i in {0..$PROXY_PORT_NUMBER}
do
    let port=8080+$i
    echo "location /proxy/$port/ {">>/etc/nginx/proxy.conf
    echo "  proxy_pass http://127.0.0.1:$port/;">>/etc/nginx/proxy.conf
    echo "}">>/etc/nginx/proxy.conf
done
}

BOOT() {
    nginx
    code-server --bind-addr 0.0.0.0:7000 ${WORKDIR}
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