#!/bin/bash

# Install and configure zsh and oh my zsh
DIR="${HOME}/dotfiles"
ZSH_FOLDER="zsh"
ZSHRC=".zshrc"

sudo apt install zsh -y
chsh -s $(which zsh)
sudo apt install wget -y
sudo apt install git -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv .oh-my-zsh ZSH_FOLDER

ln -sf "${DIR}/${ZSH_FOLDER}/${ZSHRC}" "${HOME}/${ZSHRC}"
