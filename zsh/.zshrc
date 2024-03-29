export EDITOR="vi"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# aliases
alias cat="batcat --pager=never"
alias less="batcat --pager=\"less -RF\""
alias ls="lsd"
alias scurl="curl --tlsv1.2 --proto https"
alias sudo="sudo "
alias update-system="sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt purge && sudo apt clean && sudo journalctl --vacuum-time=100d"

# starship
eval "$(starship init zsh)"

# miniconda3
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
