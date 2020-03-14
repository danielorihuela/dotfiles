#!/bin/bash

DIR="${HOME}/dotfiles"

# Install and configure zsh and oh my zsh
ZSH_FOLDER="zsh"
ZSHRC=".zshrc"

apt install zsh -y
chsh -s $(which zsh)
apt install wget -y
apt install git -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv .oh-my-zsh ZSH_FOLDER

ln -sf "${DIR}/${ZSH_FOLDER}/${ZSHRC}" "${HOME}/${ZSHRC}"

# Install and configure vim
VIM_FOLDER="vim"
VIMRC=".vimrc"

apt install vim -y
ln -sf "${DIR}/${VIM_FOLDER}/${VIMRC}" "${HOME}/${VIMRC}"
