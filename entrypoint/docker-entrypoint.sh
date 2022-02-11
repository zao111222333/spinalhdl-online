#! /bin/zsh
if [ ${WORKDIR} != /DIR/ ];
then
    mkdir -p ${WORKDIR}
    rm -rf /DIR
fi
if [ ${USER} != admin ];
then
    useradd -ms /bin/zsh ${USER}
    cd /home
    rm -rf /home/${USER}
    mv /home/admin /home/${USER}
    echo "${USER} ALL=(ALL) ALL">>/etc/sudoers
    userdel admin
fi
echo "${USER}:${PASSWORD}" | chpasswd
echo "if [ \"\$(ls -A \$WORKDIR)\" = \"\" ]; then cd $WORKDIR && git clone https://github.com/SpinalHDL/SpinalTemplateSbt.git ; fi">>/home/${USER}/.zshrc
echo "git config --global http.sslVerify false">>/home/${USER}/.zshrc

mkdir /run/sshd \
&& rm -f /etc/ssh/ssh_*_key \
&& ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key \
&& ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key \
&& ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
&& ssh-keygen -A \
&& /usr/sbin/sshd &
# rm $(su ${USER} --command "echo $HOME")/.ssh
ln -s /KEY /home/${USER}/.ssh
ln -s /SBT/local/ /usr/local/sbt/
ln -s /SBT/share/ /usr/share/sbt/
chown -R ${USER} ${WORKDIR}
chown -R ${USER} /home/${USER}
su ${USER} --command "ln -s ~/.zsh.d/zinit ~/.zinit"
htpasswd -bc /etc/nginx/htpasswd ${USER} ${PASSWORD}
for i in {0..$GDK_MAX_PORT}
do
    let port=5000+$i
    # cp /opt/gtkwave/online/gtkwave.online /opt/gtkwave/online/gtkwave.$i
    # cp /opt/gtkwave/online/broadwayd.online /opt/gtkwave/online/broadwayd.$i
    echo "location /gtk3/$i/ {">>/etc/nginx/gtk3.conf
    echo "sub_filter '<title>Gtkwave Online</title>'  '<title>$i: Gtkwave Online</title>';">>/etc/nginx/gtk3.conf
    echo "proxy_pass http://127.0.0.1:$port/;">>/etc/nginx/gtk3.conf
    echo "}">>/etc/nginx/gtk3.conf
    su ${USER} --command "/opt/gtk/bin/broadwayd -p $port :$i"&
done
nginx
su ${USER} --command "code-server --bind-addr 127.0.0.1:7000 ${WORKDIR}"