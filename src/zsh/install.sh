#! /bin/bash
tar -zxf zsh.d.tgz -C ${HOME}
mv ${HOME}/zsh.d ${HOME}/.zsh.d
cp zshrc ${HOME}/.zshrc
chmod -R 755 ${HOME}/.zsh.d
ln -s ${HOME}/.zsh.d/zinit ${HOME}/.zinit