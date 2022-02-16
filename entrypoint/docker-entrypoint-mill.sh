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
if [ ${USER} != admin ]
then
    useradd -ms /bin/zsh ${USER}
    cd /home
    rm -rf /home/${USER}
    mv /home/admin /home/${USER}
    userdel admin
fi
echo "${USER}:${PASSWORD}" | chpasswd
# echo "if [ \"\$(ls -A \$WORKDIR)\" = \"\" ]; then cd $WORKDIR && git clone https://github.com/SpinalHDL/SpinalTemplateSbt.git ; fi">>/home/${USER}/.zshrc
# echo "git config --global http.sslVerify false">>/home/${USER}/.zshrc

mkdir /run/sshd \
&& rm -f /etc/ssh/ssh_*_key \
&& ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key \
&& ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key \
&& ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
&& ssh-keygen -A \
&& /usr/sbin/sshd &
mkdir /KEY
rm -rf /home/${USER}/.ssh
ln -s /KEY   /home/${USER}/.ssh
chown -R ${USER} /KEY
chown -R ${USER} ${WORKDIR}
chown -R ${USER} /home/${USER}
su ${USER} --command "ln -s ~/.zsh.d/zinit ~/.zinit"
htpasswd -bc /etc/nginx/htpasswd ${USER} ${PASSWORD}
for i in {0..$GDK_MAX_PORT}
do
    let port=5000+$i
    echo "location /gtk3/$i/ {">>/etc/nginx/gtk3.conf
    echo "proxy_pass http://127.0.0.1:$port/;">>/etc/nginx/gtk3.conf
    echo "}">>/etc/nginx/gtk3.conf
done

echo "${USER} ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
}

BOOT() {
for i in {0..$GDK_MAX_PORT}
do
    let port=5000+$i
    su ${USER} --command "/opt/gtk/bin/broadwayd -p $port :$i"&
done
nginx
su ${USER} --command "code-server --bind-addr 127.0.0.1:7000 --proxy-domain localhost:8848 ${WORKDIR}"
}
# code-server --host 0.0.0.0 --port $UID --proxy-domain $UID.domain.tld

if [ ! -f /DOCKER_BOOT_LOCK ];then
    echo "FIRST BOOT"
    touch /DOCKER_BOOT_LOCK
    chmod 000 /DOCKER_BOOT_LOCK
    FIRST_BOOT
    BOOT
else
    echo "REBOOT"
    BOOT
fi

