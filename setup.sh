#!/bin/bash

# Constants
DOTFILES=$PWD
CONFIG=$HOME/".config"

# Import helper functions
source ./helper.sh

# Install packages
silent_install curl
silent_install wget
silent_install git
silent_install flameshot
silent_install firefox
silent_install texlive-latex-extra  
sudo add-apt-repository ppa:aslatter/ppa -y 1>/dev/null
sudo apt-get update 1>/dev/null
silent_install alacritty

silent_install zsh
chsh -s $(which zsh)

# Configure the environment
show_configure_message zsh
ln -sf $DOTFILES/zsh/.zshrc $HOME

show_configure_message starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
ln -sf $DOTFILES/startship/starship.toml $CONFIG

show_configure_message emacs
mkdir -p $CONFIG/emacs
ln -sf $DOTFILES/emacs/init.el $HOME/.emacs.d/

show_configure_message alacritty
ln -sf $DOTFILES/alacritty/alacritty.yml $CONFIG

echo -e "\n\nConfiguration ended. some changes will not take effect until the next time you log in."
