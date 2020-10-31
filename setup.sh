#!/bin/bash

echo -e "\n\nCHECK THAT YOU ARE EXECUTING WITH SUDO (sudo ./setup.sh)\n\n"
if [ -z "$1" ]
then
    echo "Insert username (e.j., sudo ./setup.sh user_example)"
    exit
fi

if [ -z "$(id $1 2>/dev/null)" ]
then
    echo 'Username introduced is not valid'
    exit
fi

USERNAME="$1"
USERHOME="/home/${USERNAME}"
DOTFILES="${USERHOME}/dotfiles"

silent_install() {
    echo "Installing \`$1\`..."
    apt-get install "$1" -y 1>/dev/null
}


# Install and configure zsh and oh my zsh
silent_install zsh
silent_install wget
silent_install git

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH="zsh"
ZSHRC=".zshrc"
OH_MY_ZSH=".oh-my-zsh"

rm -rf "${DOTFILES}/${ZSH}/${OH_MY_ZSH}"
mv "${HOME}/${OH_MY_ZSH}" "${DOTFILES}/${ZSH}"
chown -R "${USERNAME}":"${USERNAME}" "${DOTFILES}/${ZSH}"
ln -sf "${DOTFILES}/${ZSH}/${ZSHRC}" "${USERHOME}/${ZSHRC}"

# Install and configure neovim
silent_install neovim

NEOVIM="neovim"
NEOVIM_INIT="init.vim"
NEOVIM_CONFIG=".config/nvim"

rm -rf "${USERHOME}/${NEOVIM_CONFIG}"
mkdir "${USERHOME}/${NEOVIM_CONFIG}"
chown -R "${USERNAME}":"${USERNAME}" "${USERHOME}/${NEOVIM_CONFIG}"
ln -sf "${DOTFILES}/${NEOVIM}/${NEOVIM_INIT}" "${USERHOME}/${NEOVIM_CONFIG}/${NEOVIM_INIT}"
