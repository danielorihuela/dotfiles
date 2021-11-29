#!/bin/bash

silent_install() {
    echo "Installing \`$1\`..."
    sudo apt-get install "$1" -y 1>/dev/null
}

silent_install curl
silent_install wget
silent_install git
silent_install flameshot
silent_install firefox
silent_install keepasscx 
silent_install emacs27
silent_install texlive-latex-extra  
sudo add-apt-repository ppa:aslatter/ppa -y 1>/dev/null
sudo apt-get update 1>/dev/null
silent_install alacritty

silent_install zsh
chsh -s $(which zsh)



show_configure_message() {
    echo "Configuring \`$1\`..."
}

create_symbolic_link() {
    ln -sf $DOTFILES/$1 $2
}

DOTFILES=$PWD
CONFIG=$HOME/".config"

show_configure_message zsh
create_symbolic_link zsh/.zshrc $HOME

show_configure_message starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
create_symbolic_link startship/starship.toml $CONFIG

show_configure_message emacs
mkdir -p $CONFIG/emacs
create_symbolic_link emacs/init.el $HOME/.emacs.d/

show_configure_message alacritty
create_symbolic_link alacritty/alacritty.yml $CONFIG

echo -e "\n\nConfiguration ended. some changes will not take effect until the next time you log in."
