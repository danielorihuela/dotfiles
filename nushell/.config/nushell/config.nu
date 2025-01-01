# Nushell Config File
#
# version = "0.101.0"
$env.config.buffer_editor = "vi"

alias cat = batcat --pager=never
alias less = batcat --pager="less -RF"

def update-system [] {
    sudo apt update;
    sudo apt upgrade;
    sudo apt autoremove;
    sudo apt purge;
    sudo apt clean;
    sudo journalctl --vacuum-time=100d
}

use ~/.cache/starship/init.nu
