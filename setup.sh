#!/bin/bash

silent_install() {
    echo "Installing \`$1\`..."
    sudo apt-get install "$1" -y 1>/dev/null
}

# Install tools

silent_install curl
silent_install wget
silent_install git
silent_install kitty
silent_install neovim
silent_install flameshot
silent_install emacs
# Sqlite3 is required for org-roam
silent_install sqlite3
silent_install libsqlite3-dev
# Required to export org-mode to pdf
silent_install texlive-latex-extra
# Required for citations
silent_install biber
silent_install zsh
echo "Installing oh my zsh..."
export ZSH=$PWD/zsh/.oh-my-zsh
# chsh -s $(which zsh)
rm -rf $ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended


# Configuring tools

show_configure_message() {
    echo "Configuring \`$1\`..."
}

DOTFILES=$PWD
CONFIG=".config"

show_configure_message zsh
show_configure_message "oh my zsh"
ln -sf $DOTFILES/zsh/.zshrc $HOME/.zshrc


show_configure_message neovim
NEOVIM="nvim"
NEOVIM_INIT="init.vim"
NEOVIM_CONFIG=$CONFIG/$NEOVIM

rm -rf $HOME/$NEOVIM_CONFIG
mkdir $HOME/$NEOVIM_CONFIG
chown -R $USERNAME:$USERNAME $HOME/$NEOVIM_CONFIG
ln -sf $DOTFILES/$NEOVIM/$NEOVIM_INIT $HOME/$NEOVIM_CONFIG/$NEOVIM_INIT


show_configure_message emacs
mkdir $HOME/.config/emacs
ln -sf $DOTFILES/emacs/.emacs $HOME/.emacs

# Using termite at the moment
#show_configure_message kitty
#ln -sf $DOTFILES/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

show_configure_message termite
cd termite; bash setup.sh; cd ..
ln -sf $DOTFILES/termite/config $HOME/.config/termite/config
