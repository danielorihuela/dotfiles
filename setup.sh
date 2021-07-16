#!/bin/bash

silent_install() {
    echo "Installing \`$1\`..."
    sudo apt-get install "$1" -y 1>/dev/null
}

# INSTALL TOOLS 
silent_install curl
silent_install wget
silent_install git
silent_install flameshot
silent_install emacs
# Sqlite3 is required for org-roam
silent_install sqlite3
silent_install libsqlite3-dev
# Required to export org-mode to pdf
silent_install texlive-latex-extra
# Required for citations
silent_install biber
#Required to install alacritty
sudo add-apt-repository ppa:aslatter/ppa
silent_install alacritty
silent_install fish
chsh -s $(which fish)


# CONFIGURING TOOLS

show_configure_message() {
    echo "Configuring \`$1\`..."
}

DOTFILES=$PWD
CONFIG=$HOME/".config"


show_configure_message fish
rm -rf $CONFIG/fish
ln -sf $DOTFILES/fish $CONFIG/


show_configure_message starship
ln -sf $DOTFILES/startship/starship.toml $CONFIG


show_configure_message emacs
mkdir -p $CONFIG/emacs
ln -sf $DOTFILES/emacs/init.el $HOME/.emacs.d/


show_configure_message alacritty
ALACRITTY="alacritty"
ln -sf $DOTFILES/$ALACRITTY/alacritty.yml $CONFIG/alacritty.yml


echo -e "\n\nConfiguration ended. some changes will not take effect until the next time you log in."
