#!/bin/bash

DIR="${HOME}/dotfiles"

# Install my personal kanban
KANBAN_FOLDER="kanban"
KANBAN_COMMAND="kanban"
PERSONAL_KANBAN="my_personal_kanban"

wget https://github.com/greggigon/my-personal-kanban/blob/master/my-personal-kanban-0.8.0.zip\?raw\=true
mv "my-personal-kanban-0.8.0.zip?raw=true" "${KANBAN_FOLDER}/my-personal-kanban-0.8.0.zip"
unzip "${KANBAN_FOLDER}/my-personal-kanban-0.8.0.zip" -d "${KANBAN_FOLDER}"
chmod +x "${KANBAN_FOLDER}}/${KANBAN_COMMAND}"
cp "${KANBAN_FOLDER}/${KANBAN_COMMAND}" "/bin/${KANBAN_COMMAND}"

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
