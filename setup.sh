#!/bin/bash

source utils.sh

if [[ -z $(which apt-get) ]]; then
    echo "APT package manager not installed"
    exit 1;
fi

print_title "INSTALL SCRIPT REQUIREMENTS"
install_apt curl
install_apt gpg
install_apt stow

print_title "ADDING APT REPOSITORIES"
echo "Adding wezterm apt repository..."
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list > /dev/null
echo "Adding eza apt repository..."
curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --yes --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list > /dev/null
sudo apt-get update 1>/dev/null


print_title "INSTALL PACKAGES"
packages=(wget git bat ripgrep eza wezterm zsh firefox flameshot)
for package in ${packages[@]}; do
    install_apt $package
done

# APT doesn't contain starship
echo "Installing \`starship\`..."
curl -fsSL https://starship.rs/install.sh | sudo sh -s -- -y 1>/dev/null
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip FiraCode

# APT doesn't contain nushell
install_rust_github_release "nushell" "https://github.com/nushell/nushell" nu

print_title "SET NUSHELL AS DEFAULT SHELL"
nu_shell=$(which nu)
if [[ -z $(cat /etc/shells | grep $nu_shell) ]]; then
    echo $nu_shell | sudo tee -a /etc/shells
fi
chsh -s $nu_shell

print_title "CONFIGURE STARSHIP"
mkdir ~/.cache/starship
starship init nu > ~/.cache/starship/init.nu

print_title "SYMLINK CONFIGURATIONS"
echo "Symlinking configurations..."
stow -t $HOME */
