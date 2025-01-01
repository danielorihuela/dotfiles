export EDITOR="vi"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# aliases
alias cat="batcat --pager=never"
alias less="batcat --pager=\"less -RF\""
alias ls="eza"
alias scurl="curl --tlsv1.2 --proto https"
alias sudo="sudo "
alias update-system="sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt purge && sudo apt clean && sudo journalctl --vacuum-time=100d"

# starship
eval "$(starship init zsh)"
