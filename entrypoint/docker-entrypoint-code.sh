#! /bin/bash
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
chown -R ${USER} ${WORKDIR}
chown -R ${USER} /home/${USER}
su ${USER} --command "ln -s ~/.zsh.d/zinit ~/.zinit"
su ${USER} --command "code-server --bind-addr 0.0.0.0:8080 ${WORKDIR}"


